// SPDX-License-Identifier: MIT

//pragma solidity >=0.8.2 <0.9.0;

//pragma solidity >=0.4.23 <0.9.0;
pragma solidity ^0.8.18;

//import "https://github.com/ConsenSysMesh/openzeppelin-solidity/blob/master/contracts/math/SafeMath.sol";

interface IAction{
    function iAmReady() external pure returns(string memory);

}

abstract contract Whois {
    function WhoAmI() public virtual returns(string memory);
}

contract VeliUysal {
    function getFullName() public pure returns(string memory){
        return "Veli Uysal";
    }
}

//SimpleContract'ı IAcyion'dan türetelim:
contract SimpleContract is IAction, Whois, VeliUysal{
    //using SafeMath for uint; // import SafeMath
    bool public allowed;
    uint public count;
    int public signedCount;
    //string private errorMessage = "is not Allowed";
    //mapping(address => bool) public allowance; //mapping icinde erisilmek istenen adres buraya gonderilir. karsılıgında bool 1/0 dönülür
    
    mapping(address => mapping(address => bool) ) public allowance;

    //error mesaj listesi olusturalım:
    string[2] public errorMessages;  //fixed size array
    //string[] public errorMessages;  //unfixed size
    address public owner; //hangi adres bu contract ın sahibi olacak

    //event, blok zinciri dışı 3. partiyapıların bunu izleyebilmesi için kullanılır
    //Event Driven Development - EDD
    //Biz bu event i tetikliyoruz, bunu dinleyen başka bir yapı bu sayede kullanıcısı uyarabiliyor.
    //Bazı verilerin EVM üzerinde kontrat deposuna konmasını sağlar.
    event ContractCreated(address indexed owner, uint256 creationTime); //event imzası oluşturuldu




    //Struct tanımlarız:
    struct Account{
        string name;
        string surname;
        uint256 balance;
    }

    //Account public account;
    Account account;

    //Bu struct degerlerini benim adresime girmek ve istediğimde bu degerleri kullanabilmek istiyorum. Bunun için mapping yapılır:
    //Adres tipindeki bir degiskene karsilik olarak struct Account tipinde degisken yazabiliriz:
    mapping(address => Account) public accountValues;
   
    //Array olusturalım:
    //Account[3] public admins; //fixed array
    Account[] public admins; 
    uint private index;

    //constructor tanımlamamız lazım:
    constructor(){
        owner=msg.sender;
        errorMessages[0] = "is not allowed";
        errorMessages[1] = "only owner";
        //errorMessages.push("is not allowed"); 
        //errorMessages.push("only owner"); 
        //emit ile EVM'e event oluşturuldugu bildirilir
        emit ContractCreated(owner, block.timestamp);

    }

    function setAllowed(bool _owner) public {
        allowed = _owner;
    }
    modifier isAllowed() {
        require(allowance[owner][msg.sender],errorMessages[0]);
        _;
    }

    modifier OnlyOwner(){
        require(owner == msg.sender, errorMessages[1] );
        _;
    }

    function buy() isAllowed public  {

    }

    function oneIncrement() public {
        ++count;
    }

    function increment(uint _increment) isAllowed public{
        count = count + _increment;
        //count.nul(); //import SafeMath
    }

    function signedIncrement(int _increment) public {
        signedCount = signedCount + _increment;
    }

    function assignAllowence(address _address) public OnlyOwner{ 
        allowance[owner][_address] = true; //belli bir adrese yetki tanimladim

    }
    function getSizeOfErrorMessages() public view returns(uint){

        return errorMessages.length;
    }

    //Tanımladığımız struct ı dısarıdan veri alınır hale getiririz.
    function assignValue(string memory _name, string memory _surname, uint256 _balance) public {
        account.name = _name;
        account.surname = _surname;
        account.balance = _balance;
    }

    function assignValueStruct(Account memory _account) public {
        account = _account;
        // atama tuple: ["rumeysa","yer",600]
    }

    function getAccount() public view returns (Account memory){
        Account memory _account = account;
        return _account;
    }

    function assignAddressValues(Account memory _account) public{
        accountValues[msg.sender] = _account;
    }

    function addAdmin(Account memory admin) public {
        require(index<10, "has no slot");
        //admins[index++] = admin;
        admins.push(admin);
 
    }

    function getAllAdmins() public view returns(Account[] memory){
        //Account[3] memory _admins; //dinamik bir dizi olusturduk
        ///Account[] memory _admins = new Account[](0);
        //for(uint i=0; i<3; i++){
            //_admins[i] = admins[i];
        //}

        ///for(uint i=0;i<_admins.length;i++){
            ///_admins[i] = admins[i];
            //_admins[i].push(admins[i]);
        ///}
        return admins;
    }

    function iAmReady() external pure returns(string memory){
        return "I am ready!";

    }

    function WhoAmI() public  override pure returns(string memory){
        return "0xVeli";
    }
    

}
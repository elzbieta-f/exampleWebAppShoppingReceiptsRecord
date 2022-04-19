/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lt.bit.buhalterijawebjpa.data;

import java.util.Date;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table (name="cekiai")
public class Cekis {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Temporal(TemporalType.DATE)
    private Date data;
    private String parduotuve;
    private String komentaras;
    
    @OneToMany (mappedBy="cekis")
    private List<Preke>prekes;

    public Cekis() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public String getParduotuve() {
        return parduotuve;
    }

    public void setParduotuve(String parduotuve) {
        this.parduotuve = parduotuve;
    }

    public String getKomentaras() {
        return komentaras;
    }

    public void setKomentaras(String komentaras) {
        this.komentaras = komentaras;
    }

    public List<Preke> getPrekes() {
        return prekes;
    }

    public void setPrekes(List<Preke> prekes) {
        this.prekes = prekes;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 23 * hash + this.id;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Cekis other = (Cekis) obj;
        if (this.id != other.id) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Cekis{" + "id=" + id + ", data=" + data + ", parduotuve=" + parduotuve + ", komentaras=" + komentaras + ", prekes=" + prekes + '}';
    }
    
    
}

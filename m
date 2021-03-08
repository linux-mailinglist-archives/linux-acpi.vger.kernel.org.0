Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B22331A32
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 23:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCHWbC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 17:31:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2666 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhCHWaj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Mar 2021 17:30:39 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvXvb0ypyz67m9W;
        Tue,  9 Mar 2021 06:24:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 23:30:37 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 22:30:35 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Tue, 9 Mar 2021 06:30:34 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [Linuxarm]  Re: [RFC PATCH v4 3/3] scheduler: Add cluster
 scheduler level for x86
Thread-Topic: [Linuxarm]  Re: [RFC PATCH v4 3/3] scheduler: Add cluster
 scheduler level for x86
Thread-Index: AQHXDu+AE3PNeTodl0O2xkA7PHQps6pv+jeAgAIZXACACJ6u4A==
Date:   Mon, 8 Mar 2021 22:30:33 +0000
Message-ID: <6d8940e227324c2c88474d9d0769c001@hisilicon.com>
References: <20210301225940.16728-1-song.bao.hua@hisilicon.com>
 <20210301225940.16728-4-song.bao.hua@hisilicon.com>
 <YD4T0qBBgR6fPbQb@hirez.programming.kicks-ass.net>
 <a8474bae-5d9a-8c0b-766a-7188ed71320b@linux.intel.com>
In-Reply-To: <a8474bae-5d9a-8c0b-766a-7188ed71320b@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.229]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGltIENoZW4gW21haWx0
bzp0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDQs
IDIwMjEgNzozNCBBTQ0KPiBUbzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
PjsgU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKQ0KPiA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5j
b20+DQo+IENjOiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbEBrZXJuZWwub3JnOyByandA
cmp3eXNvY2tpLm5ldDsNCj4gdmluY2VudC5ndWl0dG90QGxpbmFyby5vcmc7IGJwQGFsaWVuOC5k
ZTsgdGdseEBsaW51dHJvbml4LmRlOw0KPiBtaW5nb0ByZWRoYXQuY29tOyBsZW5iQGtlcm5lbC5v
cmc7IGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbTsNCj4gcm9zdGVkdEBnb29kbWlzLm9yZzsgYnNl
Z2FsbEBnb29nbGUuY29tOyBtZ29ybWFuQHN1c2UuZGU7DQo+IG1zeXMubWl6dW1hQGdtYWlsLmNv
bTsgdmFsZW50aW4uc2NobmVpZGVyQGFybS5jb207DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnOyBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiBq
dXJpLmxlbGxpQHJlZGhhdC5jb207IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzdWRlZXAuaG9sbGFA
YXJtLmNvbTsNCj4gYXVicmV5LmxpQGxpbnV4LmludGVsLmNvbTsgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmc7DQo+IHh1d2VpIChPKSA8eHV3
ZWk1QGh1YXdlaS5jb20+OyBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsN
Cj4gZ3VvZG9uZy54dUBsaW5hcm8ub3JnOyB5YW5neWljb25nIDx5YW5neWljb25nQGh1YXdlaS5j
b20+OyBMaWd1b3podSAoS2VubmV0aCkNCj4gPGxpZ3Vvemh1QGhpc2lsaWNvbi5jb20+OyBsaW51
eGFybUBvcGVuZXVsZXIub3JnOyBocGFAenl0b3IuY29tDQo+IFN1YmplY3Q6IFtMaW51eGFybV0g
UmU6IFtSRkMgUEFUQ0ggdjQgMy8zXSBzY2hlZHVsZXI6IEFkZCBjbHVzdGVyIHNjaGVkdWxlcg0K
PiBsZXZlbCBmb3IgeDg2DQo+IA0KPiANCj4gDQo+IE9uIDMvMi8yMSAyOjMwIEFNLCBQZXRlciBa
aWpsc3RyYSB3cm90ZToNCj4gPiBPbiBUdWUsIE1hciAwMiwgMjAyMSBhdCAxMTo1OTo0MEFNICsx
MzAwLCBCYXJyeSBTb25nIHdyb3RlOg0KPiA+PiBGcm9tOiBUaW0gQ2hlbiA8dGltLmMuY2hlbkBs
aW51eC5pbnRlbC5jb20+DQo+ID4+DQo+ID4+IFRoZXJlIGFyZSB4ODYgQ1BVIGFyY2hpdGVjdHVy
ZXMgKGUuZy4gSmFjb2JzdmlsbGUpIHdoZXJlIEwyIGNhaGNlDQo+ID4+IGlzIHNoYXJlZCBhbW9u
ZyBhIGNsdXN0ZXIgb2YgY29yZXMgaW5zdGVhZCBvZiBiZWluZyBleGNsdXNpdmUNCj4gPj4gdG8g
b25lIHNpbmdsZSBjb3JlLg0KPiA+DQo+ID4gSXNuJ3QgdGhhdCBtb3N0IGF0b21zIG9uZSB3YXkg
b3IgYW5vdGhlcj8gVHJlbW9udCBzZWVtcyB0byBoYXZlIGl0IHBlciA0DQo+ID4gY29yZXMsIGJ1
dCBlYXJsaWVyIGl0IHdhcyBwZXIgMiBjb3Jlcy4NCj4gPg0KPiANCj4gWWVzLCBvbGRlciBBdG9t
cyBoYXZlIDIgY29yZXMgc2hhcmluZyBMMi4gIEkgcHJvYmFibHkgc2hvdWxkDQo+IHJlcGhyYXNl
IG15IGNvbW1lbnRzIHRvIG5vdCBsZWF2ZSB0aGUgaW1wcmVzc2lvbiB0aGF0IHNoYXJpbmcNCj4g
TDIgYW1vbmcgY29yZXMgaXMgbmV3IGZvciBBdG9tcy4NCj4gDQo+IFRyZW1vbnQgYmFzZWQgQXRv
bSBDUFVzIGluY3JlYXNlcyB0aGUgcG9zc2libGUgbG9hZCBpbWJhbGFuY2UgbW9yZQ0KPiB3aXRo
IDQgY29yZXMgcGVyIEwyIGluc3RlYWQgb2YgMi4gIEFuZCBhbHNvIHdpdGggbW9yZSBvdmVyYWxs
IGNvcmVzIG9uIGEgZGllLA0KPiB0aGUNCj4gY2hhbmNlIGluY3JlYXNlcyBmb3IgcGFja2luZyBy
dW5uaW5nIHRhc2tzIG9uIGEgZmV3IGNsdXN0ZXJzIHdoaWxlIGxlYXZpbmcNCj4gb3RoZXJzIGVt
cHR5IG9uIGxpZ2h0L21lZGl1bSBsb2FkZWQgc3lzdGVtcy4gIFdlIGRpZCBzZWUNCj4gdGhpcyBl
ZmZlY3Qgb24gSmFjb2JzdmlsbGUuDQo+IA0KPiBTbyBsb2FkIGJhbGFuY2luZyBiZXR3ZWVuIHRo
ZSBMMiBjbHVzdGVycyBpcyBtb3JlDQo+IHVzZWZ1bCBvbiBUcmVtb250IGJhc2VkIEF0b20gQ1BV
cyBjb21wYXJlZCB0byB0aGUgb2xkZXIgQXRvbXMuDQoNCkl0IHNlZW1zIHNlbnNpYmxlIHRoZSBt
b3JlIENQVSB3ZSBnZXQgaW4gdGhlIGNsdXN0ZXIsIHRoZSBtb3JlDQp3ZSBuZWVkIHRoZSBrZXJu
ZWwgdG8gYmUgYXdhcmUgb2YgaXRzIGV4aXN0ZW5jZS4NCg0KVGltLCBpdCBpcyBwb3NzaWJsZSBm
b3IgeW91IHRvIGJyaW5nIHVwIHRoZSBjcHVfY2x1c3Rlcl9tYXNrIGFuZA0KY2x1c3Rlcl9zaWJs
aW5nIGZvciB4ODYgc28gdGhhdCB0aGUgdG9wb2xvZ3kgY2FuIGJlIHJlcHJlc2VudGVkDQppbiBz
eXNmcyBhbmQgYmUgdXNlZCBieSBzY2hlZHVsZXI/IEl0IHNlZW1zIHlvdXIgcGF0Y2ggbGFja3Mg
dGhpcw0KcGFydC4NCg0KQlRXLCBJIHdvbmRlciBpZiB4ODYgY2FuIGRvIHNvbWUgaW1wcm92ZW1l
bnQgb24geW91ciBLTVBfQUZGSU5JVFkNCmJ5IGxldmVyYWdpbmcgdGhlIGNsdXN0ZXIgdG9wb2xv
Z3kgbGV2ZWwuDQpodHRwczovL3NvZnR3YXJlLmludGVsLmNvbS9jb250ZW50L3d3dy91cy9lbi9k
ZXZlbG9wL2RvY3VtZW50YXRpb24vY3BwLWNvbXBpbGVyLWRldmVsb3Blci1ndWlkZS1hbmQtcmVm
ZXJlbmNlL3RvcC9vcHRpbWl6YXRpb24tYW5kLXByb2dyYW1taW5nLWd1aWRlL29wZW5tcC1zdXBw
b3J0L29wZW5tcC1saWJyYXJ5LXN1cHBvcnQvdGhyZWFkLWFmZmluaXR5LWludGVyZmFjZS1saW51
eC1hbmQtd2luZG93cy5odG1sDQoNCktNUF9BRkZJTklUWSBoYXMgdGhyZWFkIGFmZmluaXR5IG1v
ZGVzIGxpa2UgY29tcGFjdCBhbmQgc2NhdHRlciwNCml0IHNlZW1zIHRoaXMgImNvbXBhY3QiIGFu
ZCAic2NhdHRlciIgY2FuIGFsc28gdXNlIHRoZSBjbHVzdGVyDQppbmZvcm1hdGlvbiBhcyB5b3Ug
c2VlIHdlIGFyZSBhbHNvIHN0cnVnZ2xpbmcgd2l0aCB0aGUgImNvbXBhY3QiDQphbmQgInNjYXR0
ZXIiIGlzc3VlcyBoZXJlIGluIHRoaXMgcGF0Y2hzZXQgOi0pDQoNClRoYW5rcw0KQmFycnkNCg==

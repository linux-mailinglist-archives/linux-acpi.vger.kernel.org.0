Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEB32CC886
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 22:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgLBU7F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 15:59:05 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2195 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgLBU7F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 15:59:05 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CmWSr0bRYz67FYS;
        Thu,  3 Dec 2020 04:55:24 +0800 (CST)
Received: from lhreml717-chm.china.huawei.com (10.201.108.68) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 2 Dec 2020 21:58:22 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml717-chm.china.huawei.com (10.201.108.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Wed, 2 Dec 2020 20:58:21 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Thu, 3 Dec 2020 04:58:19 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Cc: Len Brown" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
Thread-Topic: [RFC PATCH v2 2/2] scheduler: add scheduler level for clusters
Thread-Index: AQHWx46tyJL5OgLpakCat9sEfhhBKKni9KEAgACKRLD//5RWAIAAjDiggAAA9pCAAKpoUA==
Date:   Wed, 2 Dec 2020 20:58:19 +0000
Message-ID: <414fbd167b214452b925ac674575f0d6@hisilicon.com>
References: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
 <20201201025944.18260-3-song.bao.hua@hisilicon.com>
 <CAKfTPtAppZFdku6k3cA=kNYKjU5e7w4A+E3R5_m11z+jy_WCBw@mail.gmail.com>
 <f9d9c6e959e441ec94264891ae90c11d@hisilicon.com>
 <CAKfTPtDqpQBcjq03cJEKN99XOZdNuV560ja9S-oZzkq7BToR8w@mail.gmail.com>  
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.246]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiANCj4gU29ycnkuIFBsZWFzZSBpZ25vcmUgdGhpcy4gSSBhZGRlZCBzb21lIHByaW50ayBoZXJl
IHdoaWxlIHRlc3RpbmcNCj4gb25lIG51bWEuIFdpbGwgdXBkYXRlIHlvdSB0aGUgZGF0YSBpbiBh
bm90aGVyIGVtYWlsLg0KDQpSZS10ZXN0ZWQgaW4gb25lIE5VTUEgbm9kZShjcHUwLWNwdTIzKToN
Cg0KZz0xDQpSdW5uaW5nIGluIHRocmVhZGVkIG1vZGUgd2l0aCAxIGdyb3VwcyB1c2luZyA0MCBm
aWxlIGRlc2NyaXB0b3JzDQpFYWNoIHNlbmRlciB3aWxsIHBhc3MgMTAwMDAwIG1lc3NhZ2VzIG9m
IDEwMCBieXRlcw0Kdy9vOiA3LjY4OSA3LjQ4NSA3LjQ4NSA3LjQ1OCA3LjUyNCA3LjUzOSA3Ljcz
OCA3LjY5MyA3LjU2OCA3LjY3ND03LjU4NTMNCncvIDogNy41MTYgNy45NDEgNy4zNzQgNy45NjMg
Ny44ODEgNy45MTAgNy40MjAgNy41NTYgNy42OTUgNy40NDE9Ny42Njk3DQp3LyBidXQgZHJvcHBl
ZCBzZWxlY3RfaWRsZV9jbHVzdGVyOg0KICAgICA3Ljc1MiA3LjczOSA3LjczOSA3LjU3MSA3LjU0
NSA3LjY4NSA3LjQwNyA3LjU4MCA3LjYwNSA3LjQ4Nz03LjYxMQ0KDQpnPTINClJ1bm5pbmcgaW4g
dGhyZWFkZWQgbW9kZSB3aXRoIDIgZ3JvdXBzIHVzaW5nIDQwIGZpbGUgZGVzY3JpcHRvcnMNCkVh
Y2ggc2VuZGVyIHdpbGwgcGFzcyAxMDAwMDAgbWVzc2FnZXMgb2YgMTAwIGJ5dGVzDQp3L286IDEw
LjEyNyAxMC4xMTkgMTAuMDcwIDEwLjE5NiAxMC4wNTcgMTAuMTExIDEwLjA0NSAxMC4xNjQgMTAu
MTYyDQo5Ljk1NT0xMC4xMDA2DQp3LyA6IDkuNjk0IDkuNjU0IDkuNjEyIDkuNjQ5IDkuNjg2IDku
NzM0IDkuNjA3IDkuODQyIDkuNjkwIDkuNzEwPTkuNjg3OA0Kdy8gYnV0IGRyb3BwZWQgc2VsZWN0
X2lkbGVfY2x1c3RlcjoNCiAgICAgOS44NzcgMTAuMDY5IDkuOTUxIDkuOTE4IDkuOTQ3IDkuNzkw
IDkuOTA2IDkuODIwIDkuODYzIDkuOTA2PTkuOTA0Nw0KDQpnPTMNClJ1bm5pbmcgaW4gdGhyZWFk
ZWQgbW9kZSB3aXRoIDMgZ3JvdXBzIHVzaW5nIDQwIGZpbGUgZGVzY3JpcHRvcnMNCkVhY2ggc2Vu
ZGVyIHdpbGwgcGFzcyAxMDAwMDAgbWVzc2FnZXMgb2YgMTAwIGJ5dGVzDQp3L286IDE1Ljg4NSAx
NS4yNTQgMTUuOTMyIDE1LjY0NyAxNi4xMjAgMTUuODc4IDE1Ljg1NyAxNS43NTkgMTUuNjc0DQox
NS43MjE9MTUuNzcyNw0Kdy8gOiAxNC45NzQgMTQuNjU3IDEzLjk2OSAxNC45ODUgMTQuNzI4IDE1
LjY2NSAxNS4xOTEgMTQuOTk1IDE0Ljk0Ng0KMTQuODk1PTE0LjkwMDUNCncvIGJ1dCBkcm9wcGVk
IHNlbGVjdF9pZGxlX2NsdXN0ZXI6DQogICAgIDE1LjQwNSAxNS4xNzcgMTUuMzczIDE1LjE4NyAx
NS40NTAgMTUuNTQwIDE1LjI3OCAxNS42MjggMTUuMjI4IDE1LjMyNT0xNS4zNTkxDQoNCmc9NA0K
UnVubmluZyBpbiB0aHJlYWRlZCBtb2RlIHdpdGggNCBncm91cHMgdXNpbmcgNDAgZmlsZSBkZXNj
cmlwdG9ycw0KRWFjaCBzZW5kZXIgd2lsbCBwYXNzIDEwMDAwMCBtZXNzYWdlcyBvZiAxMDAgYnl0
ZXMNCncvbzogMjAuMDE0IDIxLjAyNSAyMS4xMTkgMjEuMjM1IDE5Ljc2NyAyMC45NzEgMjAuOTYy
IDIwLjkxNCAyMS4wOTAgMjEuMDkwPTIwLjgxODcNCncvIDogMjAuMzMxIDIwLjYwOCAyMC4zMzgg
MjAuNDQ1IDIwLjQ1NiAyMC4xNDYgMjAuNjkzIDIwLjc5NyAyMS4zODEgMjAuNDUyPTIwLjU2NDcN
CncvIGJ1dCBkcm9wcGVkIHNlbGVjdF9pZGxlX2NsdXN0ZXI6DQogICAgIDE5LjgxNCAyMC4xMjYg
MjAuMjI5IDIwLjM1MCAyMC43NTAgMjAuNDA0IDE5Ljk1NyAxOS44ODggMjAuMjI2IDIwLjU2Mj0y
MC4yMzA2DQoNClRoYW5rcw0KQmFycnkNCg0K

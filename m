Return-Path: <linux-acpi+bounces-6110-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CEF8D5B24
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2024 09:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EF21F23F96
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2024 07:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC5B80C1D;
	Fri, 31 May 2024 07:04:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D868004E
	for <linux-acpi@vger.kernel.org>; Fri, 31 May 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717139067; cv=none; b=Uv/DagnplaYT73JOes1d9dPEZ3e0zIZII5wIKzagWcAimRcv0gTxNsplDzDW4z5oMVWQcVSfMJ8BFX1stSFRzVcTFdCBjV/53+girVwfpgaZ3NwMfYA8h0jwn/JxLFopQ2B4O0K/1biRZeyDn30OgsJHMPGgJ2PWMwYtZZTklzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717139067; c=relaxed/simple;
	bh=lcn/WRn4tuYxb3wZ5bV1UpkIeHIxRpNeQzxNuetkF6Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H+69RQ/Vn47N48ZlRFv3bHcEc+rUs7/+rjDMSJ/Z4zm7b7aeDnXFPsGMzmicMk7tsH2wrjQQ5mKBB1uNF1pz5yJoq85tVJpnKWoUbtTksuQGH7TIbzseEFs5a2dTu2oN454dazlLYYQRCKXKLYFM3UMERtSosU26fYmQHS53Cu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1717139062-086e23110716a50001-I98ny2
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id TOX1gDREyvcukL0n (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 31 May 2024 15:04:22 +0800 (CST)
X-Barracuda-Envelope-From: LindaChai@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 31 May
 2024 15:04:21 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 31 May
 2024 15:04:21 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com ([::1]) by zxbjmbx1.zhaoxin.com
 ([fe80::b125:97ff:1c5d:c6ca%3]) with mapi id 15.01.2507.027; Fri, 31 May 2024
 15:04:21 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
From: "Linda Chai(BJ-RD)" <LindaChai@zhaoxin.com>
To: "ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>
CC: "Cobe Chen(BJ-RD)" <CobeChen@zhaoxin.com>, LeoLiu-oc
	<LeoLiu-oc@zhaoxin.com>, "Linda Chai(BJ-RD)" <LindaChai@zhaoxin.com>, "Tim
 Guo(BJ-RD)" <TimGuo@zhaoxin.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "j.granados@samsung.com"
	<j.granados@samsung.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "robert.moore@intel.com" <robert.moore@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 3/3] ACPI: cpufreq: Add ITMT support when CPPC enabled for
 Zhaoxin CPUs
Thread-Topic: Re: [PATCH 3/3] ACPI: cpufreq: Add ITMT support when CPPC
 enabled for Zhaoxin CPUs
X-ASG-Orig-Subj: Re: [PATCH 3/3] ACPI: cpufreq: Add ITMT support when CPPC enabled for
 Zhaoxin CPUs
Thread-Index: AdqzKGx5se4bWMonTx2xsC8Nn5RcCA==
Date: Fri, 31 May 2024 07:04:21 +0000
Message-ID: <48a2010eaf4e4eb9963117724ea93d61@zhaoxin.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1717139062
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 7590
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.00
X-Barracuda-Spam-Status: No, SCORE=-2.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=THREAD_INDEX, THREAD_TOPIC
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125586
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 THREAD_INDEX           thread-index: AcO7Y8iR61tzADqsRmmc5wNiFHEOig==
	0.01 THREAD_TOPIC           Thread-Topic: ...(Japanese Subject)...

SGkgLFJpY2FyZG8NCkFib3V0IHRoaXMgaXRtdCBkdW1wbGljYXRlZCBjb2RlIGluIGludGVsLXBz
dGF0ZSBhbmQgYWNwaS1jcHVmcmVxIGRyaXZlcjsNCmhvdyBhYm91dCB3ZSBwdXQgdGhlc2UgY29t
bW9uIGNvZGVzIGluIGFyY2gveDg2L2tlcm5lbC9pdG10LmM/DQppbiBpbnRlbC1wc3RhdGUvYWNw
aS1jcHVmcmVxIGRyaXZlciwgaXQgb25seSBnZXQgaGlnaGVzdCBmcmVxdWVuY3kgdGhyb3VnaCBj
cHBjIGludGVyZmFjZSBhbmQgY2FsbCBzY2hlZF9zZXRfaXRtdF9jb3JlX3ByaW8gcHJvdmlkZWQg
YnkgaXRtdC5jOw0KICAgIGluIHRoZSBzY2hlZF9zZXRfaXRtdF9jb3JlX3ByaW8sIGRvIHRoZXNl
IGZvbGxvd2luZyB3b3JrczoNCjEpIHNldCBjb3JlIHByaW9ydHkgYWNjb3JkaW5nIHRvIHRoZSBo
aWdoZXN0IGZyZXF1ZW5jeTsNCjIpIGNoZWNrIHdoZXRoZXIgY29yZXPigJloaWdoZXN0IGZyZXF1
ZW5jaWVzIGFyZSBkaWZmZXJlbnQsIGlmIHllcywgc2V0IGl0bXQgY2FwYWJsZSAmIGVuYWJsZTsN
CjMpIGNoZWNrIHdoZXRoZXIgYWxsIG9ubGluZSBjb3JlcyBoYXZlIHVwZGF0ZWQgY29yZSBwcmlv
cml0eSwgd2hpY2ggZ3VhcmFudGVlIHJlYnVpbGRfc2NoZWRfZG9tYWlucyB3aWxsIGdldCB0aGUg
Y29ycmVjdCBwcmlvcml0eSBpbmZvIGZvciBlYWNoIG9ubGluZSBjb3JlOw0KDQpGb2xsb3dpbmcg
dGhpcyBydWxlLCB0aGUgcGF0Y2ggbG9va3MgbGlrZSB0aGlzOg0KZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2tlcm5lbC9pdG10LmMgYi9hcmNoL3g4Ni9rZXJuZWwvaXRtdC5jDQppbmRleCA5YTdjMDNk
NDc4NjEuLmViMjRkZjI4MjZiYyAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9pdG10LmMN
CisrKyBiL2FyY2gveDg2L2tlcm5lbC9pdG10LmMNCkBAIC0yMiw2ICsyMiw3IEBADQojaW5jbHVk
ZSA8bGludXgvbXV0ZXguaD4NCiNpbmNsdWRlIDxsaW51eC9zeXNjdGwuaD4NCiNpbmNsdWRlIDxs
aW51eC9ub2RlbWFzay5oPg0KKyNpbmNsdWRlIDxsaW51eC9pdG10Lmg+DQoNCiBzdGF0aWMgREVG
SU5FX01VVEVYKGl0bXRfdXBkYXRlX211dGV4KTsNCkRFRklORV9QRVJfQ1BVX1JFQURfTU9TVExZ
KGludCwgc2NoZWRfY29yZV9wcmlvcml0eSk7DQpAQCAtMTYyLDYgKzE2MywxMyBAQCBpbnQgYXJj
aF9hc3ltX2NwdV9wcmlvcml0eShpbnQgY3B1KQ0KICAgICByZXR1cm4gcGVyX2NwdShzY2hlZF9j
b3JlX3ByaW9yaXR5LCBjcHUpOw0KfQ0KDQorLyogVGhlIHdvcmsgaXRlbSBpcyBuZWVkZWQgdG8g
YXZvaWQgQ1BVIGhvdHBsdWcgbG9ja2luZyBpc3N1ZXMgKi8NCitzdGF0aWMgdm9pZCBzY2hlZF9p
dG10X3dvcmtfZm4oc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KK3sNCisgICAgIHNjaGVkX3Nl
dF9pdG10X3N1cHBvcnQoKTsNCit9DQorc3RhdGljIERFQ0xBUkVfV09SSyhzY2hlZF9pdG10X3dv
cmssIHNjaGVkX2l0bXRfd29ya19mbik7DQorDQovKioNCiAgKiBzY2hlZF9zZXRfaXRtdF9jb3Jl
X3ByaW8oKSAtIFNldCBDUFUgcHJpb3JpdHkgYmFzZWQgb24gSVRNVA0KICAqIEBwcmlvOiAgICAg
UHJpb3JpdHkgb2YgQGNwdQ0KQEAgLTE3Niw3ICsxODQsMzYgQEAgaW50IGFyY2hfYXN5bV9jcHVf
cHJpb3JpdHkoaW50IGNwdSkNCiAgKiB0aGUgQ1BVIHByaW9yaXRpZXMuIFRoZSBzY2hlZCBkb21h
aW5zIGhhdmUgbm8NCiAgKiBkZXBlbmRlbmN5IG9uIENQVSBwcmlvcml0aWVzLg0KICAqLw0KKw0K
K3N0YXRpYyB1NjQgbWF4X2hpZ2hlc3RfcHJpbyA9IDAsIG1pbl9oaWdoZXN0X3ByaW8gPSBVNjRf
TUFYOw0KK3N0YXRpYyBib29sIGNvcmVfcHJpb3JpdHlfZGlmZj1mYWxzZTsNCitzdGF0aWMgc3Ry
dWN0IGNwdW1hc2sgY29yZV9wcmlvX2NwdW1hc2s7DQp2b2lkIHNjaGVkX3NldF9pdG10X2NvcmVf
cHJpbyhpbnQgcHJpbywgaW50IGNwdSkNCnsNCiAgICAgcGVyX2NwdShzY2hlZF9jb3JlX3ByaW9y
aXR5LCBjcHUpID0gcHJpbzsNCisgICAgIGNwdW1hc2tfc2V0X2NwdShjcHUsICZjb3JlX3ByaW9f
Y3B1bWFzayk7DQorDQorICAgICBpZiAobWF4X2hpZ2hlc3RfcHJpbyA8PSBtaW5faGlnaGVzdF9w
cmlvKQ0KKyAgICAgew0KKyAgICAgICAgICAgIGlmIChwcmlvID4gbWF4X2hpZ2hlc3RfcHJpbykN
CisgICAgICAgICAgICAgICAgICAgbWF4X2hpZ2hlc3RfcHJpbyA9IHByaW87DQorDQorICAgICAg
ICAgICAgaWYgKHByaW8gPCBtaW5faGlnaGVzdF9wcmlvKQ0KKyAgICAgICAgICAgICAgICAgICBt
aW5faGlnaGVzdF9wcmlvID0gcHJpbzsNCisNCisgICAgICAgICAgICBpZiAobWF4X2hpZ2hlc3Rf
cHJpbyA+IG1pbl9oaWdoZXN0X3ByaW8pDQorICAgICAgICAgICAgICAgICAgIGNvcmVfcHJpb3Jp
dHlfZGlmZiA9IHRydWU7DQorICAgICB9DQorDQorICAgICBpZiAoY29yZV9wcmlvcml0eV9kaWZm
ICYmIGNwdW1hc2tfZXF1YWwoJmNvcmVfcHJpb19jcHVtYXNrLCBjcHVfb25saW5lX21hc2spKQ0K
KyAgICAgew0KKyAgICAgICAgICAgIC8qDQorICAgICAgICAgICAgKiBUaGlzIGNvZGUgIGNhbiBi
ZSBydW4gZHVyaW5nIENQVSBvbmxpbmUgdW5kZXIgdGhlIENQVSBob3RwbHVnIGxvY2tzLA0KKyAg
ICAgICAgICAgICogc28gc2NoZWRfc2V0X2l0bXQgY2Fubm90IGJlIGNhbGxlZCBmcm9tIGhlcmUu
DQorICAgICAgICAgICAgKiBxdWV1ZSBhIHdvcmsgaXRlbSB0byBpbnZva2UgaXQNCisgICAgICAg
ICAgICAqLw0KKyAgICAgICAgICAgIHByX2RlYnVnKCJxdWV1ZSBhIHdvcmsgdG8gc2V0IGl0bXQg
c3VwcG9ydCBhbmQgZW5hYmxlXG4iKTsNCisgICAgICAgICAgICBzY2hlZHVsZV93b3JrKCZzY2hl
ZF9pdG10X3dvcmspOw0KKyAgICAgfQ0KKw0KfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJl
cS9hY3BpLWNwdWZyZXEuYyBiL2RyaXZlcnMvY3B1ZnJlcS9hY3BpLWNwdWZyZXEuYw0KaW5kZXgg
MzdmMWNkZjQ2ZDI5Li4zZTVlMGY2NmIyZWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NwdWZyZXEv
YWNwaS1jcHVmcmVxLmMNCisrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hY3BpLWNwdWZyZXEuYw0KQEAg
LTMwLDYgKzMwLDcgQEANCiNpbmNsdWRlIDxhY3BpL3Byb2Nlc3Nvci5oPg0KI2luY2x1ZGUgPGFj
cGkvY3BwY19hY3BpLmg+DQoNCisjaW5jbHVkZSA8bGludXgvaXRtdC5oPg0KI2luY2x1ZGUgPGFz
bS9tc3IuaD4NCiNpbmNsdWRlIDxhc20vcHJvY2Vzc29yLmg+DQojaW5jbHVkZSA8YXNtL2NwdWZl
YXR1cmUuaD4NCkBAIC02NjMsOCArNjY0LDE3IEBAIHN0YXRpYyB1NjQgZ2V0X21heF9ib29zdF9y
YXRpbyh1bnNpZ25lZCBpbnQgY3B1KQ0KDQogICAgICByZXR1cm4gZGl2X3U2NChoaWdoZXN0X3Bl
cmYgPDwgU0NIRURfQ0FQQUNJVFlfU0hJRlQsIG5vbWluYWxfcGVyZik7DQp9DQorDQorc3RhdGlj
IHZvaWQgY29yZV9zZXRfaXRtdF9wcmlvKGludCBjcHUpDQorew0KKyAgICAgdTY0IGhpZ2hlc3Rf
cGVyZjsNCisgICAgIGNwcGNfZ2V0X2hpZ2hlc3RfcGVyZihjcHUsICZoaWdoZXN0X3BlcmYpOw0K
KyAgICAgc2NoZWRfc2V0X2l0bXRfY29yZV9wcmlvKGhpZ2hlc3RfcGVyZiwgY3B1KTsNCit9DQor
DQojZWxzZQ0Kc3RhdGljIGlubGluZSB1NjQgZ2V0X21heF9ib29zdF9yYXRpbyh1bnNpZ25lZCBp
bnQgY3B1KSB7IHJldHVybiAwOyB9DQorc3RhdGljIHZvaWQgY29yZV9zZXRfaXRtdF9wcmlvKGlu
dCBjcHUpIHt9DQojZW5kaWYNCg0KIHN0YXRpYyBpbnQgYWNwaV9jcHVmcmVxX2NwdV9pbml0KHN0
cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQ0KQEAgLTY3Nyw3ICs2ODcsNyBAQCBzdGF0aWMg
aW50IGFjcGlfY3B1ZnJlcV9jcHVfaW5pdChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkN
CiAgICAgdW5zaWduZWQgaW50IHZhbGlkX3N0YXRlcyA9IDA7DQogICAgIHVuc2lnbmVkIGludCBy
ZXN1bHQgPSAwOw0KICAgICB1NjQgbWF4X2Jvb3N0X3JhdGlvOw0KLSAgICAgdW5zaWduZWQgaW50
IGk7DQorICAgICB1bnNpZ25lZCBpbnQgaSxqOw0KI2lmZGVmIENPTkZJR19TTVANCiAgICAgc3Rh
dGljIGludCBibGFja2xpc3RlZDsNCiNlbmRpZg0KQEAgLTc0MSw2ICs3NTEsMTAgQEAgc3RhdGlj
IGludCBhY3BpX2NwdWZyZXFfY3B1X2luaXQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kp
DQogICAgICAgICAgICBwcl9pbmZvX29uY2UoIm92ZXJyaWRpbmcgQklPUyBwcm92aWRlZCBfUFNE
IGRhdGFcbiIpOw0KICAgICB9DQojZW5kaWYNCisgICAgIGZvcl9lYWNoX2NwdShqLHBvbGljeS0+
Y3B1cykNCisgICAgIHsNCisgICAgICAgICAgICBjb3JlX3NldF9pdG10X3ByaW8oaik7DQorICAg
ICB9DQoNCiAgICAgIC8qIGNhcGFiaWxpdHkgY2hlY2sgKi8NCiAgICAgaWYgKHBlcmYtPnN0YXRl
X2NvdW50IDw9IDEpIHsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRl
LmMgYi9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMNCmluZGV4IGRiYmYyOTlmNDIxOS4u
NGIwNGU2ZGI5ZDViIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5j
DQorKysgYi9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMNCkBAIC0yNyw2ICsyNyw3IEBA
DQojaW5jbHVkZSA8bGludXgvcG1fcW9zLmg+DQojaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4N
CiNpbmNsdWRlIDx0cmFjZS9ldmVudHMvcG93ZXIuaD4NCisjaW5jbHVkZSA8bGludXgvaXRtdC5o
Pg0KDQogI2luY2x1ZGUgPGFzbS9jcHUuaD4NCiNpbmNsdWRlIDxhc20vZGl2NjQuaD4NCkBAIC0z
NDAsMjMgKzM0MSwxNCBAQCBzdGF0aWMgYm9vbCBpbnRlbF9wc3RhdGVfZ2V0X3BwY19lbmFibGVf
c3RhdHVzKHZvaWQpDQoNCiAjaWZkZWYgQ09ORklHX0FDUElfQ1BQQ19MSUINCg0KLS8qIFRoZSB3
b3JrIGl0ZW0gaXMgbmVlZGVkIHRvIGF2b2lkIENQVSBob3RwbHVnIGxvY2tpbmcgaXNzdWVzICov
DQotc3RhdGljIHZvaWQgaW50ZWxfcHN0c3RlX3NjaGVkX2l0bXRfd29ya19mbihzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspDQotew0KLSAgICAgc2NoZWRfc2V0X2l0bXRfc3VwcG9ydCgpOw0KLX0N
Ci0NCi1zdGF0aWMgREVDTEFSRV9XT1JLKHNjaGVkX2l0bXRfd29yaywgaW50ZWxfcHN0c3RlX3Nj
aGVkX2l0bXRfd29ya19mbik7DQotDQojZGVmaW5lIENQUENfTUFYX1BFUkYgIFU4X01BWA0KDQog
c3RhdGljIHZvaWQgaW50ZWxfcHN0YXRlX3NldF9pdG10X3ByaW8oaW50IGNwdSkNCnsNCi0gICAg
IHN0cnVjdCBjcHBjX3BlcmZfY2FwcyBjcHBjX3BlcmY7DQotICAgICBzdGF0aWMgdTMyIG1heF9o
aWdoZXN0X3BlcmYgPSAwLCBtaW5faGlnaGVzdF9wZXJmID0gVTMyX01BWDsNCisgICAgIHU2NCBo
aWdoZXN0X3BlcmY7DQogICAgIGludCByZXQ7DQoNCi0gICAgIHJldCA9IGNwcGNfZ2V0X3BlcmZf
Y2FwcyhjcHUsICZjcHBjX3BlcmYpOw0KKyAgICAgcmV0ID0gY3BwY19nZXRfaGlnaGVzdF9wZXJm
KGNwdSwmaGlnaGVzdF9wZXJmKTsNCiAgICAgaWYgKHJldCkNCiAgICAgICAgICAgIHJldHVybjsN
Cg0KQEAgLTM2NSwzMyArMzU3LDE1IEBAIHN0YXRpYyB2b2lkIGludGVsX3BzdGF0ZV9zZXRfaXRt
dF9wcmlvKGludCBjcHUpDQogICAgICAqIEluIHRoaXMgY2FzZSB3ZSBjYW4ndCB1c2UgQ1BQQy5o
aWdoZXN0X3BlcmYgdG8gZW5hYmxlIElUTVQuDQogICAgICAqIEluIHRoaXMgY2FzZSB3ZSBjYW4g
bG9vayBhdCBNU1JfSFdQX0NBUEFCSUxJVElFUyBiaXRzIFs4OjBdIHRvIGRlY2lkZS4NCiAgICAg
ICovDQotICAgICBpZiAoY3BwY19wZXJmLmhpZ2hlc3RfcGVyZiA9PSBDUFBDX01BWF9QRVJGKQ0K
LSAgICAgICAgICAgIGNwcGNfcGVyZi5oaWdoZXN0X3BlcmYgPSBIV1BfSElHSEVTVF9QRVJGKFJF
QURfT05DRShhbGxfY3B1X2RhdGFbY3B1XS0+aHdwX2NhcF9jYWNoZWQpKTsNCisgICAgIGlmICho
aWdoZXN0X3BlcmYgPT0gQ1BQQ19NQVhfUEVSRikNCisgICAgICAgICAgICBoaWdoZXN0X3BlcmYg
PSBIV1BfSElHSEVTVF9QRVJGKFJFQURfT05DRShhbGxfY3B1X2RhdGFbY3B1XS0+aHdwX2NhcF9j
YWNoZWQpKTsNCg0KICAgICAgLyoNCiAgICAgICogVGhlIHByaW9yaXRpZXMgY2FuIGJlIHNldCBy
ZWdhcmRsZXNzIG9mIHdoZXRoZXIgb3Igbm90DQogICAgICAqIHNjaGVkX3NldF9pdG10X3N1cHBv
cnQodHJ1ZSkgaGFzIGJlZW4gY2FsbGVkIGFuZCBpdCBpcyB2YWxpZCB0bw0KICAgICAgKiB1cGRh
dGUgdGhlbSBhdCBhbnkgdGltZSBhZnRlciBpdCBoYXMgYmVlbiBjYWxsZWQuDQogICAgICAqLw0K
LSAgICAgc2NoZWRfc2V0X2l0bXRfY29yZV9wcmlvKGNwcGNfcGVyZi5oaWdoZXN0X3BlcmYsIGNw
dSk7DQotDQotICAgICBpZiAobWF4X2hpZ2hlc3RfcGVyZiA8PSBtaW5faGlnaGVzdF9wZXJmKSB7
DQotICAgICAgICAgICAgaWYgKGNwcGNfcGVyZi5oaWdoZXN0X3BlcmYgPiBtYXhfaGlnaGVzdF9w
ZXJmKQ0KLSAgICAgICAgICAgICAgICAgICBtYXhfaGlnaGVzdF9wZXJmID0gY3BwY19wZXJmLmhp
Z2hlc3RfcGVyZjsNCi0NCi0gICAgICAgICAgICBpZiAoY3BwY19wZXJmLmhpZ2hlc3RfcGVyZiA8
IG1pbl9oaWdoZXN0X3BlcmYpDQotICAgICAgICAgICAgICAgICAgIG1pbl9oaWdoZXN0X3BlcmYg
PSBjcHBjX3BlcmYuaGlnaGVzdF9wZXJmOw0KLQ0KLSAgICAgICAgICAgIGlmIChtYXhfaGlnaGVz
dF9wZXJmID4gbWluX2hpZ2hlc3RfcGVyZikgew0KLSAgICAgICAgICAgICAgICAgICAvKg0KLSAg
ICAgICAgICAgICAgICAgICAqIFRoaXMgY29kZSBjYW4gYmUgcnVuIGR1cmluZyBDUFUgb25saW5l
IHVuZGVyIHRoZQ0KLSAgICAgICAgICAgICAgICAgICAqIENQVSBob3RwbHVnIGxvY2tzLCBzbyBz
Y2hlZF9zZXRfaXRtdF9zdXBwb3J0KCkNCi0gICAgICAgICAgICAgICAgICAgKiBjYW5ub3QgYmUg
Y2FsbGVkIGZyb20gaGVyZS4gIFF1ZXVlIHVwIGEgd29yayBpdGVtDQotICAgICAgICAgICAgICAg
ICAgICogdG8gaW52b2tlIGl0Lg0KLSAgICAgICAgICAgICAgICAgICAqLw0KLSAgICAgICAgICAg
ICAgICAgICBzY2hlZHVsZV93b3JrKCZzY2hlZF9pdG10X3dvcmspOw0KLSAgICAgICAgICAgIH0N
Ci0gICAgIH0NCisgICAgIHNjaGVkX3NldF9pdG10X2NvcmVfcHJpbyhoaWdoZXN0X3BlcmYsIGNw
dSk7DQp9DQoNCiBzdGF0aWMgaW50IGludGVsX3BzdGF0ZV9nZXRfY3BwY19ndWFyYW50ZWVkKGlu
dCBjcHUpDQpUaGFua3MNCkxpbmRhDQoNCg0KDQrkv53lr4blo7DmmI7vvJoNCuacrOmCruS7tuWQ
q+acieS/neWvhuaIluS4k+acieS/oeaBr++8jOS7heS+m+aMh+WumuaUtuS7tuS6uuS9v+eUqOOA
guS4peemgeWvueacrOmCruS7tuaIluWFtuWGheWuueWBmuS7u+S9leacque7j+aOiOadg+eahOaf
pemYheOAgeS9v+eUqOOAgeWkjeWItuaIlui9rOWPkeOAgg0KQ09ORklERU5USUFMIE5PVEU6DQpU
aGlzIGVtYWlsIGNvbnRhaW5zIGNvbmZpZGVudGlhbCBvciBsZWdhbGx5IHByaXZpbGVnZWQgaW5m
b3JtYXRpb24gYW5kIGlzIGZvciB0aGUgc29sZSB1c2Ugb2YgaXRzIGludGVuZGVkIHJlY2lwaWVu
dC4gQW55IHVuYXV0aG9yaXplZCByZXZpZXcsIHVzZSwgY29weWluZyBvciBmb3J3YXJkaW5nIG9m
IHRoaXMgZW1haWwgb3IgdGhlIGNvbnRlbnQgb2YgdGhpcyBlbWFpbCBpcyBzdHJpY3RseSBwcm9o
aWJpdGVkLg0K


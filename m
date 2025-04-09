Return-Path: <linux-acpi+bounces-12879-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E4CA81BCD
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 06:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890153BED01
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 04:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23891BC073;
	Wed,  9 Apr 2025 04:09:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1444A139D1B;
	Wed,  9 Apr 2025 04:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744171745; cv=none; b=EutLshhTQY5bwVpKJq2xfMJyJGuiHAHh9xKx/pJe7yQNeBRmk+xfOQ7WcBz/yWCkcggsw+WDoabpfU5IUW/p0Z3G4ywTZLOsQPAMKHSQMllfM99kkiefyV1UX0euWqu6XfiY5MN9eY/54kpaU82FNwxL6fJyt03qAmc5GILHVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744171745; c=relaxed/simple;
	bh=eA4MU4IKWkfQPtThiL78Dw2fPKO8XkGHH4PRDaNqEUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=nXHcwThcre4W6FP2bB70jMV+0HwDkEu+idbmiuBI55g4Wx9bGGduKyN7Ob0ghOKCTfROFj73Oas5bwsjVzFIsotroNXVdoznuTOeqLxIbEqpmLkmFiwqPUSLTWSANfYE6nJfhjPm0yJ2MoPfycTYQNGpPVJ4kB5B4VSY0PhCWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDX3AzW8vVnRADrEw--.29393S2;
	Wed, 09 Apr 2025 12:08:54 +0800 (CST)
Received: from wangyuquan1236$phytium.com.cn ( [218.76.62.144] ) by
 ajax-webmail-mail (Coremail) ; Wed, 9 Apr 2025 12:08:50 +0800 (GMT+08:00)
Date: Wed, 9 Apr 2025 12:08:50 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: "Dan Williams" <dan.j.williams@intel.com>
Cc: "kernel test robot" <lkp@intel.com>, Jonathan.Cameron@huawei.com,
	rppt@kernel.org, rafael@kernel.org, lenb@kernel.org,
	akpm@linux-foundation.org, alison.schofield@intel.com,
	rrichter@amd.com, bfaccini@nvidia.com, haibo1.xu@intel.com,
	david@redhat.com, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, chenbaozi@phytium.com.cn,
	linux-cxl@vger.kernel.org, loongarch@lists.linux.dev,
	chenhuacai@kernel.org, kernel@xen0n.name
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT6 build
 20240812(cfb32469) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <67eef72411bec_464ec29434@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250328092132.2695299-1-wangyuquan1236@phytium.com.cn>
 <202503282026.QNaOAK79-lkp@intel.com>
 <67eef72411bec_464ec29434@dwillia2-xfh.jf.intel.com.notmuch>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: IEHbj2Zvb3Rlcl90eHQ9Mzk4NDozODM=
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <54b74f06.68e1.19618bc860e.Coremail.wangyuquan1236@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwDHzYnS8vVn3SxkAA--.9751W
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAPAWf1gRgDF
	gACsT
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jr48JFWftF48Aw13XFW7CFg_yoWDGw1fpa
	18A34UAw1UKw1xK3yfKw18Ary8G3y5Wr47Jw4Iy39Iyw47JrsxXwnrKFW7J3Wjga4Yqrs8
	tw13Zws0qr1jywUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Cj4gW2FkZCBsb29uZ2FyY2ggZm9sa3MsIGNjIGxpbnV4LWN4bCBdCj4gCj4ga2VybmVsIHRlc3Qg
cm9ib3Qgd3JvdGU6Cj4gPiBIaSBZdXF1YW4sCj4gPiAKPiA+IGtlcm5lbCB0ZXN0IHJvYm90IG5v
dGljZWQgdGhlIGZvbGxvd2luZyBidWlsZCBlcnJvcnM6Cj4gPiAKPiA+IFthdXRvIGJ1aWxkIHRl
c3QgRVJST1Igb24gYWtwbS1tbS9tbS1ldmVyeXRoaW5nXQo+ID4gCj4gPiB1cmw6ICAgIGh0dHBz
Oi8vZ2l0aHViLmNvbS9pbnRlbC1sYWItbGtwL2xpbnV4L2NvbW1pdHMvWXVxdWFuLVdhbmcvbW0t
bnVtYV9tZW1ibGtzLWludHJvZHVjZS1udW1hX2FkZF9yZXNlcnZlZF9tZW1ibGsvMjAyNTAzMjgt
MTcyNDI4Cj4gPiBiYXNlOiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L2FrcG0vbW0uZ2l0IG1tLWV2ZXJ5dGhpbmcKPiA+IHBhdGNoIGxpbms6ICAgIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAzMjgwOTIxMzIuMjY5NTI5OS0xLXdhbmd5dXF1
YW4xMjM2JTQwcGh5dGl1bS5jb20uY24KPiA+IHBhdGNoIHN1YmplY3Q6IFtQQVRDSCB2Ml0gbW06
IG51bWFfbWVtYmxrczogaW50cm9kdWNlIG51bWFfYWRkX3Jlc2VydmVkX21lbWJsawo+ID4gY29u
ZmlnOiBsb29uZ2FyY2gtcmFuZGNvbmZpZy0wMDItMjAyNTAzMjggKGh0dHBzOi8vZG93bmxvYWQu
MDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDI1MDMyOC8yMDI1MDMyODIwMjYuUU5hT0FLNzktbGtw
QGludGVsLmNvbS9jb25maWcpCj4gPiBjb21waWxlcjogbG9vbmdhcmNoNjQtbGludXgtZ2NjIChH
Q0MpIDE0LjIuMAo+ID4gcmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKTogKGh0dHBzOi8v
ZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDI1MDMyOC8yMDI1MDMyODIwMjYuUU5h
T0FLNzktbGtwQGludGVsLmNvbS9yZXByb2R1Y2UpCj4gPiAKPiA+IElmIHlvdSBmaXggdGhlIGlz
c3VlIGluIGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0IGEgbmV3IHZlcnNp
b24gb2YKPiA+IHRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRh
Z3MKPiA+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgo+
ID4gfCBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyNTAz
MjgyMDI2LlFOYU9BSzc5LWxrcEBpbnRlbC5jb20vCj4gPiAKPiA+IEFsbCBlcnJvcnMgKG5ldyBv
bmVzIHByZWZpeGVkIGJ5ID4+KToKPiA+IAo+ID4gICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGlu
Y2x1ZGUvbGludXgvYnVpbGRfYnVnLmg6NSwKPiA+ICAgICAgICAgICAgICAgICAgICAgZnJvbSBp
bmNsdWRlL2xpbnV4L2NvbnRhaW5lcl9vZi5oOjUsCj4gPiAgICAgICAgICAgICAgICAgICAgIGZy
b20gaW5jbHVkZS9saW51eC9saXN0Lmg6NSwKPiA+ICAgICAgICAgICAgICAgICAgICAgZnJvbSBp
bmNsdWRlL2xpbnV4L21vZHVsZS5oOjEyLAo+ID4gICAgICAgICAgICAgICAgICAgICBmcm9tIGRy
aXZlcnMvYWNwaS9udW1hL3NyYXQuYzoxMDoKPiA+ICAgIGRyaXZlcnMvYWNwaS9udW1hL3NyYXQu
YzogSW4gZnVuY3Rpb24gJ2FjcGlfcGFyc2VfY2Ztd3MnOgo+ID4gPj4gZHJpdmVycy9hY3BpL251
bWEvc3JhdC5jOjQ2MToxMzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9u
ICdudW1hX2FkZF9yZXNlcnZlZF9tZW1ibGsnIFstV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0
aW9uXQo+ID4gICAgICA0NjEgfCAgICAgICAgIGlmIChudW1hX2FkZF9yZXNlcnZlZF9tZW1ibGso
bm9kZSwgc3RhcnQsIGVuZCkgPCAwKSB7Cj4gPiAgICAgICAgICB8ICAgICAgICAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fgo+IAo+IFNvIGl0IGxvb2tzIGxpa2UgbG9vbmdhcmNoIHdhcyBs
ZWZ0IG91dCBvZiB0aGUgbnVtYV9tZW1ibGtzIGNvbnZlcnNpb246Cj4gODc0ODI3MDgyMTBmICgi
bW06IGludHJvZHVjZSBudW1hX21lbWJsa3MiKQo+IAo+IEkgdGhpbmsgdGhlIHVwZGF0ZSBuZWVk
ZWQgaXMgc29tZXRoaW5nIGxpa2UgdGhpcyAodW50ZXN0ZWQpOgo+IAo+IGRpZmYgLS1naXQgYS9h
cmNoL2xvb25nYXJjaC9LY29uZmlnIGIvYXJjaC9sb29uZ2FyY2gvS2NvbmZpZwo+IGluZGV4IDJi
OGJkMjdhODUyZi4uY2FjMTZjODI3MTU5IDEwMDY0NAo+IC0tLSBhL2FyY2gvbG9vbmdhcmNoL0tj
b25maWcKPiArKysgYi9hcmNoL2xvb25nYXJjaC9LY29uZmlnCj4gQEAgLTE4Myw2ICsxODMsNyBA
QCBjb25maWcgTE9PTkdBUkNICj4gICBzZWxlY3QgTU9EVUxFU19VU0VfRUxGX1JFTEEgaWYgTU9E
VUxFUwo+ICAgc2VsZWN0IE5FRURfUEVSX0NQVV9FTUJFRF9GSVJTVF9DSFVOSwo+ICAgc2VsZWN0
IE5FRURfUEVSX0NQVV9QQUdFX0ZJUlNUX0NIVU5LCj4gKyBzZWxlY3QgTlVNQV9NRU1CTEtTCj4g
ICBzZWxlY3QgT0YKPiAgIHNlbGVjdCBPRl9FQVJMWV9GTEFUVFJFRQo+ICAgc2VsZWN0IFBDSQo+
IGRpZmYgLS1naXQgYS9hcmNoL2xvb25nYXJjaC9pbmNsdWRlL2FzbS9udW1hLmggYi9hcmNoL2xv
b25nYXJjaC9pbmNsdWRlL2FzbS9udW1hLmgKPiBpbmRleCBiNWY5ZGU5ZjEwMmUuLmJiZjlmNzBi
ZDI1ZiAxMDA2NDQKPiAtLS0gYS9hcmNoL2xvb25nYXJjaC9pbmNsdWRlL2FzbS9udW1hLmgKPiAr
KysgYi9hcmNoL2xvb25nYXJjaC9pbmNsdWRlL2FzbS9udW1hLmgKPiBAQCAtMjIsMjAgKzIyLDYg
QEAgZXh0ZXJuIGludCBudW1hX29mZjsKPiAgZXh0ZXJuIHMxNiBfX2NwdWlkX3RvX25vZGVbQ09O
RklHX05SX0NQVVNdOwo+ICBleHRlcm4gbm9kZW1hc2tfdCBudW1hX25vZGVzX3BhcnNlZCBfX2lu
aXRkYXRhOwo+ICAKPiAtc3RydWN0IG51bWFfbWVtYmxrIHsKPiAtIHU2NCBzdGFydDsKPiAtIHU2
NCBlbmQ7Cj4gLSBpbnQgbmlkOwo+IC19Owo+IC0KPiAtI2RlZmluZSBOUl9OT0RFX01FTUJMS1Mg
KE1BWF9OVU1OT0RFUyoyKQo+IC1zdHJ1Y3QgbnVtYV9tZW1pbmZvIHsKPiAtIGludCBucl9ibGtz
Owo+IC0gc3RydWN0IG51bWFfbWVtYmxrIGJsa1tOUl9OT0RFX01FTUJMS1NdOwo+IC19Owo+IC0K
PiAtZXh0ZXJuIGludCBfX2luaXQgbnVtYV9hZGRfbWVtYmxrKGludCBub2RlaWQsIHU2NCBzdGFy
dCwgdTY0IGVuZCk7Cj4gLQo+ICBleHRlcm4gdm9pZCBfX2luaXQgZWFybHlfbnVtYV9hZGRfY3B1
KGludCBjcHVpZCwgczE2IG5vZGUpOwo+ICBleHRlcm4gdm9pZCBudW1hX2FkZF9jcHUodW5zaWdu
ZWQgaW50IGNwdSk7Cj4gIGV4dGVybiB2b2lkIG51bWFfcmVtb3ZlX2NwdSh1bnNpZ25lZCBpbnQg
Y3B1KTsKPiBkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gva2VybmVsL251bWEuYyBiL2FyY2gv
bG9vbmdhcmNoL2tlcm5lbC9udW1hLmMKPiBpbmRleCA4NGZlN2Y4NTQ4MjAuLjU3YjIxMDgyZTg5
MyAxMDA2NDQKPiAtLS0gYS9hcmNoL2xvb25nYXJjaC9rZXJuZWwvbnVtYS5jCj4gKysrIGIvYXJj
aC9sb29uZ2FyY2gva2VybmVsL251bWEuYwo+IEBAIC0xOCw2ICsxOCw3IEBACj4gICNpbmNsdWRl
IDxsaW51eC9lZmkuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L2lycS5oPgo+ICAjaW5jbHVkZSA8bGlu
dXgvcGNpLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9udW1hX21lbWJsa3MuaD4KPiAgI2luY2x1ZGUg
PGFzbS9ib290aW5mby5oPgo+ICAjaW5jbHVkZSA8YXNtL2xvb25nc29uLmg+Cj4gICNpbmNsdWRl
IDxhc20vbnVtYS5oPgo+IAo+IENvdWxkIHNvbWVvbmUgZnJvbSB0aGUgbG9vbmdhcmNoIHNpZGUg
cHJvcG9zZSB0aGUgZml4dXBzIG5lZWRlZCBoZXJlIHNvCj4gWXVxdWFuIGNhbiBsYW5kIHRoaXMg
cGF0Y2g/CgpIaSwgRGFuCgpTaG91bGQgSSB3YWl0IGZvciBMb29uZ2FyY2ggZm9sa3MncyByZXBs
aWVzIG9yIGRyYWZ0IGEgbmV3IHBhdGNoIGZvciBMb29uZ2FyY2gKdG8gaW50cm9kdWNlIG51bWFf
bWVtYmxrcyBhY2NvcmRpbmcgdG8geW91ciBzdWdnZXN0ZWQgY29kZT8KCll1cXVhbgoKDQoNCuS/
oeaBr+WuieWFqOWjsOaYju+8muacrOmCruS7tuWMheWQq+S/oeaBr+W9kuWPkeS7tuS6uuaJgOWc
qOe7hOe7h+aJgOaciSzlj5Hku7bkurrmiYDlnKjnu4Tnu4flr7nor6Xpgq7ku7bmi6XmnInmiYDm
nInmnYPliKnjgILor7fmjqXmlLbogIXms6jmhI/kv53lr4Ys5pyq57uP5Y+R5Lu25Lq65Lmm6Z2i
6K645Y+vLOS4jeW+l+WQkeS7u+S9leesrOS4ieaWuee7hOe7h+WSjOS4quS6uumAj+mcsuacrOmC
ruS7tuaJgOWQq+S/oeaBr+OAgg0KSW5mb3JtYXRpb24gU2VjdXJpdHkgTm90aWNlOiBUaGUgaW5m
b3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgbWFpbCBpcyBzb2xlbHkgcHJvcGVydHkgb2YgdGhl
IHNlbmRlcidzIG9yZ2FuaXphdGlvbi5UaGlzIG1haWwgY29tbXVuaWNhdGlvbiBpcyBjb25maWRl
bnRpYWwuUmVjaXBpZW50cyBuYW1lZCBhYm92ZSBhcmUgb2JsaWdhdGVkIHRvIG1haW50YWluIHNl
Y3JlY3kgYW5kIGFyZSBub3QgcGVybWl0dGVkIHRvIGRpc2Nsb3NlIHRoZSBjb250ZW50cyBvZiB0
aGlzIGNvbW11bmljYXRpb24gdG8gb3RoZXJzLg==



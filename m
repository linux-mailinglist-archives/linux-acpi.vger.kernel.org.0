Return-Path: <linux-acpi+bounces-13768-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AC3ABAAED
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 17:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 723B97A17D3
	for <lists+linux-acpi@lfdr.de>; Sat, 17 May 2025 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6001E25F9;
	Sat, 17 May 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="P2W/zNuF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652A6F073;
	Sat, 17 May 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747497511; cv=none; b=jPMvFEmDw5T0rluChuYBu45gTGYuH5HzpZo7qE/2PMnhrysS+jCVKWEJGiwITAGxNBge7ew+0DOt4NqS4kFvm4le6iPCW++Z5wrYyROH+crAP9U+Gj3wMXpPLv0YH1osSb214+rbNDJc8YJ6OEZ2n9KuvVlyWL3EzIQwRCMUIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747497511; c=relaxed/simple;
	bh=+nKc/SYrRs0W4Sq2YMephvP0OOXu3UzSyW6VwNtSYMc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=IVOg9zZQdkBNN2PVaMVXAwstoXnGWYHZIblmozGqFyqsok3at7Um2YHJwUwuPBkTTRPPgTQMkAHhXuKUqvvKWQLch/V8S2NlYZ6uD3O68AKk9itEcxfTp1PH12ZcRS2UVGv/ZVrKTL7ygHtD+cHBRmssQYahYrYLWdNv1Nqmdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=P2W/zNuF; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747497506; x=1748102306; i=w_armin@gmx.de;
	bh=JSgOgQqHoPHvnxnf+b1brkrkC7rGGnOi+lef/hoyuJc=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
	 Subject:To:Cc:References:From:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P2W/zNuFmPzDUFnptH1/ASfoYPe4ZBJPBycZaCSMWljzwuBG1rad1W6o0Sx6cTAA
	 On+rw/2flch3ieQ/5oXsBQgqCS364GQkuOauO/oKmb+/KRI5R3lFwew/Bqs1+bF4+
	 A2aAWbpc5T2gcJqI8eUXCdifJKHnbRAxOJNSyIRb5lnrREnq+a4Cxt9kJvM0wvqoL
	 SybNN0HY+Szkd6a/8Zfe0nDCw8ef9TqOSi5DJfJY0SOKLkWT0DKDACaRosKbKVTvE
	 z5rrqGNlwhJ2wQaIiRMvTdGu7cPE+CihTJhj+yT9pSPe1hVPAqxYLLC+czvqYn6Jw
	 iF0Pt7hvkmWR4e1qeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4b1y-1uHyMB3tkU-00CuZa; Sat, 17
 May 2025 17:58:26 +0200
Content-Type: multipart/mixed; boundary="------------UNoV6QFu5kw0ttPSXzHxCbzk"
Message-ID: <b3536162-44aa-40af-861e-07371497ef30@gmx.de>
Date: Sat, 17 May 2025 17:58:24 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: lenovo: Unbreak USB/BT keyboards on non-ACPI
 platforms
To: Janne Grunau <j@jannau.net>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Vishnu Sankar <vishnuocv@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250512-hid_lenovo_unbreak_non_acpi-v1-1-e9e37ecbfbfe@jannau.net>
 <b77edae0-50bd-4039-9487-15bb69389c6c@gmx.de>
 <20250515230537.GA1556976@robin.jannau.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250515230537.GA1556976@robin.jannau.net>
X-Provags-ID: V03:K1:ya83VZF2f1odBPj/iAj3hu/JGWtmtz6sevlUh0ETa97J6wLpdLG
 EjTJijlKSn+q5XciW798jc+tTF7lVnpMBsz7FhHCl2XNh7gji68U7ADa0UO4GM8QIcyadYo
 89U43JqWVg72TyTS6LrFimHSbQyh72Oys/uNISwG3bhmAHgd+j6NYwcyn22CJrJoTvRFmKX
 kzjTYsIPrSsUe95lYDEdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mM71ThfNg3Q=;X3norQu0a50rZ1Y+57RYaTzZugs
 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
 6SzldzQJwaHyLaE6kiGAEVakoyaLu2CtuH

This is a multi-part message in MIME format.
--------------UNoV6QFu5kw0ttPSXzHxCbzk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 16.05.25 um 01:05 schrieb Janne Grunau:

> On Fri, May 16, 2025 at 12:05:11AM +0200, Armin Wolf wrote:
>> Am 12.05.25 um 23:55 schrieb Janne Grunau via B4 Relay:
>>
>>> From: Janne Grunau <j@jannau.net>
>>>
>>> Commit 84c9d2a968c8 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 Kbd
>>> Fn keys") added a dependency on ACPI_PLATFORM_PROFILE to cycle through
>>> power profiles. This breaks USB and Bluetooth keyboards on non-ACPI
>>> platforms since platform_profile_init() fails. See the warning below for
>>> the visible symptom but cause is the dependency on the platform_profile
>>> module.
>>>
>>> [  266.225052] kernel: usb 1-1.3.2: new full-speed USB device number 9 using xhci_hcd
>>> [  266.316032] kernel: usb 1-1.3.2: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
>>> [  266.327129] kernel: usb 1-1.3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>>> [  266.327623] kernel: usb 1-1.3.2: Product: ThinkPad Compact USB Keyboard with TrackPoint
>>> [  266.328096] kernel: usb 1-1.3.2: Manufacturer: Lenovo
>>> [  266.337488] kernel: ------------[ cut here ]------------
>>> [  266.337551] kernel: WARNING: CPU: 4 PID: 2619 at fs/sysfs/group.c:131 internal_create_group+0xc0/0x358
>>> [  266.337584] kernel: Modules linked in: platform_profile(+) nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft>
>>> [  266.337685] kernel:  apple_sio spi_apple apple_dart soundcore spmi_apple_controller pinctrl_apple_gpio i2c_pasemi_platform apple_admac i2c_pasemi_core clk_apple_nco xhci_pla>
>>> [  266.337717] kernel: CPU: 4 UID: 0 PID: 2619 Comm: (udev-worker) Tainted: G S      W          6.14.4-400.asahi.fc41.aarch64+16k #1
>>> [  266.337750] kernel: Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
>>> [  266.337776] kernel: Hardware name: Apple Mac mini (M1, 2020) (DT)
>>> [  266.337808] kernel: pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>>> [  266.337834] kernel: pc : internal_create_group+0xc0/0x358
>>> [  266.337860] kernel: lr : sysfs_create_group+0x20/0x40
>>> [  266.337886] kernel: sp : ffff800086f877a0
>>> [  266.337914] kernel: x29: ffff800086f877b0 x28: 0000000000000000 x27: ffffb66d0b338348
>>> [  266.337939] kernel: x26: ffffb66d0b338358 x25: ffffb66d528c7c50 x24: ffffb66d507e37b0
>>> [  266.337965] kernel: x23: 0000fffebf6708d8 x22: 0000000000000000 x21: ffffb66d0b370340
>>> [  266.337991] kernel: x20: ffffb66d0b370308 x19: 0000000000000000 x18: 0000000000000000
>>> [  266.338029] kernel: x17: 554e514553007373 x16: ffffb66d4f8c2268 x15: 595342555300656c
>>> [  266.338051] kernel: x14: 69666f72702d6d72 x13: 00353236353d4d55 x12: 4e51455300737361
>>> [  266.338075] kernel: x11: ffff6adf91b80100 x10: 0000000000000139 x9 : ffffb66d4f8c2288
>>> [  266.338097] kernel: x8 : ffff800086f87620 x7 : 0000000000000000 x6 : 0000000000000000
>>> [  266.338116] kernel: x5 : ffff6adfc896e100 x4 : 0000000000000000 x3 : ffff6adfc896e100
>>> [  266.338139] kernel: x2 : ffffb66d0b3703a0 x1 : 0000000000000000 x0 : 0000000000000000
>>> [  266.338155] kernel: Call trace:
>>> [  266.338173] kernel:  internal_create_group+0xc0/0x358 (P)
>>> [  266.338193] kernel:  sysfs_create_group+0x20/0x40
>>> [  266.338206] kernel:  platform_profile_init+0x48/0x3ff8 [platform_profile]
>>> [  266.338224] kernel:  do_one_initcall+0x60/0x358
>>> [  266.338239] kernel:  do_init_module+0x94/0x260
>>> [  266.338257] kernel:  load_module+0x5e0/0x708
>>> [  266.338271] kernel:  init_module_from_file+0x94/0x100
>>> [  266.338290] kernel:  __arm64_sys_finit_module+0x268/0x360
>>> [  266.338309] kernel:  invoke_syscall+0x6c/0x100
>>> [  266.338327] kernel:  el0_svc_common.constprop.0+0xc8/0xf0
>>> [  266.338346] kernel:  do_el0_svc+0x24/0x38
>>> [  266.338365] kernel:  el0_svc+0x3c/0x170
>>> [  266.338385] kernel:  el0t_64_sync_handler+0x10c/0x138
>>> [  266.338404] kernel:  el0t_64_sync+0x1b0/0x1b8
>>> [  266.338419] kernel: ---[ end trace 0000000000000000 ]---
>>>
>>> Fixes: 84c9d2a968c8 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 Kbd Fn keys")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Janne Grunau <j@jannau.net>
>>>
>>> ------>8---------
>>> I don't see an easy solution to keep the functionality in generic HID
>>> code which is used on non-ACPI platforms. Solution for this are not
>>> trivial so remove the functionality for now.
>>> Cc-ing the ACPI maintainers in the case they can think of a solution for
>>> this issue.
>> Hi,
>>
>> i think we can fix that. We just have to skip the compat stuff if acpi_kobj is NULL (means that ACPI is not used).
>> The modern platform profile interface is generic enough to also work on non-ACPI systems.
>>
>> Can you test a patch?
> I can easily test patches
>
> Janne

Nice, i attached the necessary patch. Please keep in mind that this patch is compile-tested only.

Thanks,
Armin Wolf

--------------UNoV6QFu5kw0ttPSXzHxCbzk
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ACPI-platform_profile-Add-support-for-non-ACPI-platf.patch"
Content-Disposition: attachment;
 filename*0="0001-ACPI-platform_profile-Add-support-for-non-ACPI-platf.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3Mzg5MTFjOWIyYzY3MWFmZGQ3Mzc0N2VlZTAyYjVlMGZhMWRiNDI4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBcm1pbiBXb2xmIDxXX0FybWluQGdteC5kZT4KRGF0
ZTogU2F0LCAxNyBNYXkgMjAyNSAxNzo0NTowOSArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIEFD
UEk6IHBsYXRmb3JtX3Byb2ZpbGU6IEFkZCBzdXBwb3J0IGZvciBub24tQUNQSSBwbGF0Zm9y
bXMKCkN1cnJlbnRseSB0aGUgcGxhdGZvcm0gcHJvZmlsZSBzdWJzeXN0ZW0gYXNzdW1lcyB0
aGF0IGFsbCBzdXBwb3J0ZWQKKGkuZS4gQUNQSS1jYXBhYmxlKSBwbGF0Zm9ybXMgYWx3YXlz
IHJ1biB3aXRoIEFDUEkgYmVpbmcgZW5hYmxlZC4KSG93ZXZlciBzb21lIEFSTTY0IG5vdGVi
b29rcyBkbyBub3Qgc3VwcG9ydCBBQ1BJIGFuZCBhcmUgaW5zdGVhZAp1c2luZyBkZXZpY2V0
cmVlIGZvciBib290aW5nLgoKRG8gbm90IHJlZ2lzdGVyIHRoZSBsZWdhY3kgc3lzZnMgaW50
ZXJmYWNlIG9uIHN1Y2ggZGV2aWNlcyBhcyBpdApkZXBlbmRzIG9uIHRoZSBhY3BpX2tvYmog
KC9zeXMvZmlybXdhcmUvYWNwaS8pIGJlaW5nIHByZXNlbnQuIFVzZXJzCmFyZSBlbmNvdXJh
Z2VkIHRvIHVzZSB0aGUgbmV3IHBsYXRmb3JtLXByb2ZpbGUgY2xhc3MgaW50ZXJmYWNlCmlu
c3RlYWQuCgpTaWduZWQtb2ZmLWJ5OiBBcm1pbiBXb2xmIDxXX0FybWluQGdteC5kZT4KLS0t
CiBkcml2ZXJzL2FjcGkvcGxhdGZvcm1fcHJvZmlsZS5jIHwgNjggKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwg
MTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3BsYXRmb3JtX3By
b2ZpbGUuYyBiL2RyaXZlcnMvYWNwaS9wbGF0Zm9ybV9wcm9maWxlLmMKaW5kZXggZmZiZmQz
MmY0Y2YxLi5jNWE1ZGE3ZDAzZjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9wbGF0Zm9y
bV9wcm9maWxlLmMKKysrIGIvZHJpdmVycy9hY3BpL3BsYXRmb3JtX3Byb2ZpbGUuYwpAQCAt
MTkwLDYgKzE5MCwyMCBAQCBzdGF0aWMgc3NpemVfdCBwcm9maWxlX3Nob3coc3RydWN0IGRl
dmljZSAqZGV2LAogCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVzXG4iLCBwcm9maWxlX25h
bWVzW3Byb2ZpbGVdKTsKIH0KIAorLyoqCisgKiBwcm9maWxlX25vdGlmeV9sZWdhY3kgLSBO
b3RpZnkgdGhlIGxlZ2FjeSBzeXNmcyBpbnRlcmZhY2UKKyAqCisgKiBUaGlzIHdyYXBwZXIg
dGFrZXMgY2FyZSBvZiBvbmx5IG5vdGlmeWluZyB0aGUgbGVnYWN5IHN5c2ZzIGludGVyZmFj
ZQorICogaWYgaXQgd2FzIHJlZ2lzdGVyZWQgZHVyaW5nIG1vZHVsZSBpbml0aWFsaXphdGlv
bi4KKyAqLworc3RhdGljIHZvaWQgcHJvZmlsZV9ub3RpZnlfbGVnYWN5KHZvaWQpCit7CisJ
aWYgKCFhY3BpX2tvYmopCisJCXJldHVybjsKKworCXN5c2ZzX25vdGlmeShhY3BpX2tvYmos
IE5VTEwsICJwbGF0Zm9ybV9wcm9maWxlIik7Cit9CisKIC8qKgogICogcHJvZmlsZV9zdG9y
ZSAtIFNldCB0aGUgcHJvZmlsZSBmb3IgYSBjbGFzcyBkZXZpY2UKICAqIEBkZXY6IFRoZSBk
ZXZpY2UKQEAgLTIxNSw3ICsyMjksNyBAQCBzdGF0aWMgc3NpemVfdCBwcm9maWxlX3N0b3Jl
KHN0cnVjdCBkZXZpY2UgKmRldiwKIAkJCXJldHVybiByZXQ7CiAJfQogCi0Jc3lzZnNfbm90
aWZ5KGFjcGlfa29iaiwgTlVMTCwgInBsYXRmb3JtX3Byb2ZpbGUiKTsKKwlwcm9maWxlX25v
dGlmeV9sZWdhY3koKTsKIAogCXJldHVybiBjb3VudDsKIH0KQEAgLTQzNSw3ICs0NDksNyBA
QCBzdGF0aWMgc3NpemVfdCBwbGF0Zm9ybV9wcm9maWxlX3N0b3JlKHN0cnVjdCBrb2JqZWN0
ICprb2JqLAogCQkJcmV0dXJuIHJldDsKIAl9CiAKLQlzeXNmc19ub3RpZnkoYWNwaV9rb2Jq
LCBOVUxMLCAicGxhdGZvcm1fcHJvZmlsZSIpOworCXByb2ZpbGVfbm90aWZ5X2xlZ2FjeSgp
OwogCiAJcmV0dXJuIGNvdW50OwogfQpAQCAtNDcyLDYgKzQ4NiwyMiBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBwbGF0Zm9ybV9wcm9maWxlX2dyb3VwID0gewog
CS5pc192aXNpYmxlID0gcHJvZmlsZV9jbGFzc19pc192aXNpYmxlLAogfTsKIAorLyoqCisg
KiBwcm9maWxlX3VwZGF0ZV9sZWdhY3kgLSBVcGRhdGUgdGhlIGxlZ2FjeSBzeXNmcyBpbnRl
cmZhY2UKKyAqCisgKiBUaGlzIHdyYXBwZXIgdGFrZXMgY2FyZSBvZiBvbmx5IHVwZGF0aW5n
IHRoZSBsZWdhY3kgc3lzZnMgaW50ZXJmYWNlCisgKiBpZiBpdCB3YXMgcmVnaXN0ZXJlZCBk
dXJpbmcgbW9kdWxlIGluaXRpYWxpemF0aW9uLgorICoKKyAqIFJldHVybjogMCBvbiBzdWNj
ZXNzIG9yIGVycm9yIGNvZGUgb24gZmFpbHVyZS4KKyAqLworc3RhdGljIGludCBwcm9maWxl
X3VwZGF0ZV9sZWdhY3kodm9pZCkKK3sKKwlpZiAoIWFjcGlfa29iaikKKwkJcmV0dXJuIDA7
CisKKwlyZXR1cm4gc3lzZnNfdXBkYXRlX2dyb3VwKGFjcGlfa29iaiwgJnBsYXRmb3JtX3By
b2ZpbGVfZ3JvdXApOworfQorCiAvKioKICAqIHBsYXRmb3JtX3Byb2ZpbGVfbm90aWZ5IC0g
Tm90aWZ5IGNsYXNzIGRldmljZSBhbmQgbGVnYWN5IHN5c2ZzIGludGVyZmFjZQogICogQGRl
djogVGhlIGNsYXNzIGRldmljZQpAQCAtNDgxLDcgKzUxMSw3IEBAIHZvaWQgcGxhdGZvcm1f
cHJvZmlsZV9ub3RpZnkoc3RydWN0IGRldmljZSAqZGV2KQogCXNjb3BlZF9jb25kX2d1YXJk
KG11dGV4X2ludHIsIHJldHVybiwgJnByb2ZpbGVfbG9jaykgewogCQlfbm90aWZ5X2NsYXNz
X3Byb2ZpbGUoZGV2LCBOVUxMKTsKIAl9Ci0Jc3lzZnNfbm90aWZ5KGFjcGlfa29iaiwgTlVM
TCwgInBsYXRmb3JtX3Byb2ZpbGUiKTsKKwlwcm9maWxlX25vdGlmeV9sZWdhY3koKTsKIH0K
IEVYUE9SVF9TWU1CT0xfR1BMKHBsYXRmb3JtX3Byb2ZpbGVfbm90aWZ5KTsKIApAQCAtNTI5
LDcgKzU1OSw3IEBAIGludCBwbGF0Zm9ybV9wcm9maWxlX2N5Y2xlKHZvaWQpCiAJCQlyZXR1
cm4gZXJyOwogCX0KIAotCXN5c2ZzX25vdGlmeShhY3BpX2tvYmosIE5VTEwsICJwbGF0Zm9y
bV9wcm9maWxlIik7CisJcHJvZmlsZV9ub3RpZnlfbGVnYWN5KCk7CiAKIAlyZXR1cm4gMDsK
IH0KQEAgLTYwMyw5ICs2MzMsOSBAQCBzdHJ1Y3QgZGV2aWNlICpwbGF0Zm9ybV9wcm9maWxl
X3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hhciAqbmFtZSwKIAkJZ290
byBjbGVhbnVwX2lkYTsKIAl9CiAKLQlzeXNmc19ub3RpZnkoYWNwaV9rb2JqLCBOVUxMLCAi
cGxhdGZvcm1fcHJvZmlsZSIpOworCXByb2ZpbGVfbm90aWZ5X2xlZ2FjeSgpOwogCi0JZXJy
ID0gc3lzZnNfdXBkYXRlX2dyb3VwKGFjcGlfa29iaiwgJnBsYXRmb3JtX3Byb2ZpbGVfZ3Jv
dXApOworCWVyciA9IHByb2ZpbGVfdXBkYXRlX2xlZ2FjeSgpOwogCWlmIChlcnIpCiAJCWdv
dG8gY2xlYW51cF9jdXI7CiAKQEAgLTYzOSw4ICs2NjksOCBAQCB2b2lkIHBsYXRmb3JtX3By
b2ZpbGVfcmVtb3ZlKHN0cnVjdCBkZXZpY2UgKmRldikKIAlpZGFfZnJlZSgmcGxhdGZvcm1f
cHJvZmlsZV9pZGEsIHBwcm9mLT5taW5vcik7CiAJZGV2aWNlX3VucmVnaXN0ZXIoJnBwcm9m
LT5kZXYpOwogCi0Jc3lzZnNfbm90aWZ5KGFjcGlfa29iaiwgTlVMTCwgInBsYXRmb3JtX3By
b2ZpbGUiKTsKLQlzeXNmc191cGRhdGVfZ3JvdXAoYWNwaV9rb2JqLCAmcGxhdGZvcm1fcHJv
ZmlsZV9ncm91cCk7CisJcHJvZmlsZV9ub3RpZnlfbGVnYWN5KCk7CisJcHJvZmlsZV91cGRh
dGVfbGVnYWN5KCk7CiB9CiBFWFBPUlRfU1lNQk9MX0dQTChwbGF0Zm9ybV9wcm9maWxlX3Jl
bW92ZSk7CiAKQEAgLTY5MiwxNiArNzIyLDI4IEBAIHN0YXRpYyBpbnQgX19pbml0IHBsYXRm
b3JtX3Byb2ZpbGVfaW5pdCh2b2lkKQogCWlmIChlcnIpCiAJCXJldHVybiBlcnI7CiAKLQll
cnIgPSBzeXNmc19jcmVhdGVfZ3JvdXAoYWNwaV9rb2JqLCAmcGxhdGZvcm1fcHJvZmlsZV9n
cm91cCk7Ci0JaWYgKGVycikKLQkJY2xhc3NfdW5yZWdpc3RlcigmcGxhdGZvcm1fcHJvZmls
ZV9jbGFzcyk7CisJLyoKKwkgKiBUaGUgQUNQSSBrb2JqZWN0IGNhbiBiZSBtaXNzaW5nIGlm
IEFDUEkgd2FzIGRpc2FibGVkIGR1cmluZyBib290aW5nLgorCSAqIFdlIHRodXMgc2tpcCB0
aGUgaW5pdGlhbGl6YXRpb24gb2YgdGhlIGxlZ2FjeSBzeXNmcyBpbnRlcmZhY2UgaW4gc3Vj
aAorCSAqIGNhc2VzIHRvIGFsbG93IHRoZSBwbGF0Zm9ybSBwcm9maWxlIGNsYXNzIHRvIHdv
cmsgb24gQVJNNjQgbm90ZWJvb2tzCisJICogd2l0aG91dCBBQ1BJIHN1cHBvcnQuCisJICov
CisJaWYgKGFjcGlfa29iaikgeworCQllcnIgPSBzeXNmc19jcmVhdGVfZ3JvdXAoYWNwaV9r
b2JqLCAmcGxhdGZvcm1fcHJvZmlsZV9ncm91cCk7CisJCWlmIChlcnIgPCAwKSB7CisJCQlj
bGFzc191bnJlZ2lzdGVyKCZwbGF0Zm9ybV9wcm9maWxlX2NsYXNzKTsKKwkJCXJldHVybiBl
cnI7CisJCX0KKwl9CiAKLQlyZXR1cm4gZXJyOworCXJldHVybiAwOwogfQogCiBzdGF0aWMg
dm9pZCBfX2V4aXQgcGxhdGZvcm1fcHJvZmlsZV9leGl0KHZvaWQpCiB7Ci0Jc3lzZnNfcmVt
b3ZlX2dyb3VwKGFjcGlfa29iaiwgJnBsYXRmb3JtX3Byb2ZpbGVfZ3JvdXApOworCWlmIChh
Y3BpX2tvYmopCisJCXN5c2ZzX3JlbW92ZV9ncm91cChhY3BpX2tvYmosICZwbGF0Zm9ybV9w
cm9maWxlX2dyb3VwKTsKKwogCWNsYXNzX3VucmVnaXN0ZXIoJnBsYXRmb3JtX3Byb2ZpbGVf
Y2xhc3MpOwogfQogbW9kdWxlX2luaXQocGxhdGZvcm1fcHJvZmlsZV9pbml0KTsKLS0gCjIu
MzkuNQoK

--------------UNoV6QFu5kw0ttPSXzHxCbzk--


Return-Path: <linux-acpi+bounces-4574-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60552892E5E
	for <lists+linux-acpi@lfdr.de>; Sun, 31 Mar 2024 04:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72401F2183F
	for <lists+linux-acpi@lfdr.de>; Sun, 31 Mar 2024 02:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E210E3;
	Sun, 31 Mar 2024 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jxSUS8Av"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC6181
	for <linux-acpi@vger.kernel.org>; Sun, 31 Mar 2024 02:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711853277; cv=none; b=EOyghBEBsJrOp4zZe5SWeuYrmDErQzAV0IKgD07btv4rvFmT8cAIn2PZ+HltkrS5ZyPcEANr4rcLzdShDHudYmJ7UPBfGSxkltcCBdLcjgiefh/GbdqfitNiPalV9UX2CidN5AT2rFCfJYITHaA3AlJ78tZJccCFd3yiL64kgW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711853277; c=relaxed/simple;
	bh=u1+btc+945ZL41pchMq+U9EKd+gJRfsjMs2Af44/+Sg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=O5YYoLNRAI2Q1qDPmyKlg6p6iBYkQz5mjVfpS+wYaXnxyAYL3YhsaJkMrCrlVwWUCE2RXdwflKU+JquNQbXgoXLZkTnAjwmsT1TxmGVcLSyz98nombSBcdY8kHjbcW+tY4RkNXvHAsP+SC/7AthQvkzJ23R74rkxv2n9DzYlQ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=jxSUS8Av; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711853268; x=1712458068; i=w_armin@gmx.de;
	bh=u1+btc+945ZL41pchMq+U9EKd+gJRfsjMs2Af44/+Sg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=jxSUS8Av3CEIeQrKgATcey9m1u/7La8V3D8bnpSChjTVJFz//GKq3KKamHpmA/h2
	 tLjy7ghs6eUXna9AVjfsQdbrPxtcMFp71p2+KFPPimO5tUh7V8mJmgo/o/H9nLnAx
	 Z10cDey0hWbTbV177xLQfe4LgXugYmHDF9zF/r6cQ0pXJaxTpUM8YUYVntAQWlV7G
	 EDSE5Id08nOJ76zz569TXT9lTF9FYmEuHEPJUuLKrSX3xD5jbE2IatSnx+294W70d
	 mlaUTK3daFEw/XJv+KIfPrRq2n7gGn/pYZGvJ9uckQAmYi/BHuZ7ndtqLJ7FFD5Vk
	 ZbPtB0vxUmrBdjffgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKGP-1s24yb12gD-00Fg04; Sun, 31
 Mar 2024 04:47:48 +0200
Content-Type: multipart/mixed; boundary="------------RPx3ATiTVOtWzCGGYaeaOQ6H"
Message-ID: <cb9c17e4-53f0-4579-879a-0a8fa1352fb9@gmx.de>
Date: Sun, 31 Mar 2024 04:46:33 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ACPI BIOS bug and memory leak?
To: Dmitry Antipov <dmantipov@yandex.ru>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org
References: <9d0a3bd8-62d6-43cc-8109-311448ad0867@yandex.ru>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <9d0a3bd8-62d6-43cc-8109-311448ad0867@yandex.ru>
X-Provags-ID: V03:K1:AR8L1Iv1Yk2gGlSzoMNoVafp+BiqSq39znuTVbYCMHZBl6cRFyl
 loMIfxC/nRLQi5+lUlYXi1HVVfHh3+SyWw0TdvURjP/ogXshQ9jGEzSre7fz3R0xmhYR4Xh
 QBznsF7ox+dQwcFVt8YGJwTcNzQZ00xy824EDaqmSB+NUtMWdlrF3DFaIS5Cre67SuHzyI6
 huY9nki94cFT2ucQwdS6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SdyNbnMAcxg=;uo+u0kgkJNBARlTb7aA01Cd/NE/
 JE/M/j6eIEtJo4744vyW6GIZ6qd1ugAiSimzdHi0Hzoj+YZIe4rY17sE5e0kmw8jwTh2IQOZd
 +qKoDNk90+QmrhGhoZX8EiE9A08XFQPGrm1hTxX+51uFhSvNW0s3iwfMWifHqnRGoBU3xnScr
 2UMD5WVjxB8eZotzH45nhCrxmapSk4smKmOiFR8Ie+Y1G+jlWp8D7srIjxL4HScmXfag6NqvU
 bYiRmdV0vSr4KqMBymncY255ygKjRUJfWftL1tXPvUqVVR/sfAhBX1FZYv+fTESdL7QWN4BGR
 TraBlFAWwX6d7dDHjPl6Pq6D4Ct1kMDtfAY7nxD8x0qZ73fWMAQav/Ns18U34nHV6/e/RJE5V
 mLf/H41CSUKuW3z4b/aeNhcLHiTI0bjG1z2zuDFAJWLUh3AIH9MorCx+cTiv3ekBDLe0aQUSd
 urUAIRKuVUCLbvqhNusaEz33H194aSdqWMtLPnYVqLijDocSojWbZ//AWcKl7rAE6WgO4T14Z
 LmAgJdyFp9ISAy75j6FaD9DAWqF6N/uGNZyiq1irs7HQKNyZTLWcJH4I94pHQVr6M11GV8Ngr
 dcJP5bfQjCpFmkaObPNrBpFXJm+VhAmFV3r73tGS8rcqrFC7F7G0moDB+x1gvCz/PWmobgqyI
 PR47cWrzjb7JD7OvUMugdlXR1I+NttZr1GTqhw+OGpl4T4O9Aqb3JPtLWt7YsItLLEf16uAUQ
 hcnd19zhnjNM0YWxyr39xmwuMCRiGeT7x+qu03w0tZPArOC1R45Y3RH8O8YaUdLA22UzhRec4
 4PVLgIyUF62UF6/ZCp01nUwsvhhGIwX7+IXmUkyokapfw=

This is a multi-part message in MIME format.
--------------RPx3ATiTVOtWzCGGYaeaOQ6H
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 27.03.24 um 11:48 schrieb Dmitry Antipov:

> Is it possible that this:
>
> [=C2=A0=C2=A0=C2=A0 7.727080] ACPI BIOS Error (bug): Could not resolve s=
ymbol
> [\_TZ.ETMD], AE_NOT_FOUND (20230628/psargs-335)
> [=C2=A0=C2=A0=C2=A0 7.728470] ACPI Error: Aborting method \_SB.IETM._OSC=
 due to
> previous error (AE_NOT_FOUND) (20230628/psparse-529)
>
> is somehow related to:
>
> unreferenced object 0xffff944e85013d58 (size 56):
> =C2=A0 comm "thermald", pid 966, jiffies 4294674933
> =C2=A0 hex dump (first 32 bytes):
> =C2=A0=C2=A0=C2=A0 00 00 00 00 00 00 00 00 0d 01 2d 00 00 00 00 00 .....=
.....-.....
> =C2=A0=C2=A0=C2=A0 94 8c 05 80 51 b8 ff ff 00 00 00 00 00 00 00 00 ....Q=
...........
> =C2=A0 backtrace (crc 41e9984d):
> =C2=A0=C2=A0=C2=A0 [<000000004b53f9d1>] kmem_cache_alloc+0x256/0x340
> =C2=A0=C2=A0=C2=A0 [<000000008d9ead3a>] acpi_ps_alloc_op+0xbf/0xd0
> =C2=A0=C2=A0=C2=A0 [<000000002f1e617e>] acpi_ps_get_next_arg+0xbb/0x6a0
> =C2=A0=C2=A0=C2=A0 [<00000000b697bac7>] acpi_ps_parse_loop+0x466/0x6b0
> =C2=A0=C2=A0=C2=A0 [<000000008dbc2acb>] acpi_ps_parse_aml+0x80/0x3c0
> =C2=A0=C2=A0=C2=A0 [<00000000b26066ae>] acpi_ps_execute_method+0x13f/0x2=
70
> =C2=A0=C2=A0=C2=A0 [<00000000f80592ab>] acpi_ns_evaluate+0x12b/0x2c0
> =C2=A0=C2=A0=C2=A0 [<00000000bbc91886>] acpi_evaluate_object+0x14e/0x310
> =C2=A0=C2=A0=C2=A0 [<000000005729c43d>] acpi_run_osc+0x158/0x270
> =C2=A0=C2=A0=C2=A0 [<00000000e6666993>] int3400_thermal_run_osc+0x73/0xc=
0
> [int3400_thermal]
> =C2=A0=C2=A0=C2=A0 [<000000000a474314>] current_uuid_store+0xd5/0x110 [i=
nt3400_thermal]
> =C2=A0=C2=A0=C2=A0 [<00000000e27be786>] kernfs_fop_write_iter+0x13e/0x1f=
0
> =C2=A0=C2=A0=C2=A0 [<00000000992f9e08>] vfs_write+0x293/0x460
> =C2=A0=C2=A0=C2=A0 [<000000008b9e130c>] ksys_write+0x6d/0xf0
> =C2=A0=C2=A0=C2=A0 [<000000007d501d09>] do_syscall_64+0x85/0x170
> =C2=A0=C2=A0=C2=A0 [<0000000073c5a34b>] entry_SYSCALL_64_after_hwframe+0=
x6c/0x74
>
> (recently observed on 6.9.0-rc1)
>
> Dmitry
>
Hi,

i thing the memory leak happens in acpi_ps_get_next_arg(). After allocatin=
g an acpi_parse_object in line 820 of psargs.c,
calling of acpi_ps_get_next_namepath() fails due to to the missing symbol.=
 The code now returns the error without freeing
the acpi_parse_object, causing a memory leak.

IMHO the solution would be to call acpi_ps_free_op() in case of an error b=
efore returning said error code. I attached an
experimental patch which might fix this, but it is still untested. If you =
want you can test if it solves the problem.

Thanks,
Armin Wolf

--------------RPx3ATiTVOtWzCGGYaeaOQ6H
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ACPICA-Fix-memory-leak-then-namespace-lookup-fails.patch"
Content-Disposition: attachment;
 filename*0="0001-ACPICA-Fix-memory-leak-then-namespace-lookup-fails.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSA2NTBjMDEwZWY3ODQxYmViYmFjYzA3NGYzNTk5MDllODQ2MzNiNGY4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBcm1pbiBXb2xmIDxXX0FybWluQGdteC5kZT4KRGF0
ZTogU3VuLCAzMSBNYXIgMjAyNCAwNDozOTo1NCArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIEFD
UElDQTogRml4IG1lbW9yeSBsZWFrIHRoZW4gbmFtZXNwYWNlIGxvb2t1cCBmYWlscwoKV2hl
biBhY3BpX3BzX2dldF9uZXh0X25hbWVwYXRoKCkgZmFpbHMgZHVlIHRvIGEgbmFtZXNwYWNl
IGxvb2t1cApmYWlsdXJlLCB0aGUgYWNwaV9wYXJzZV9vYmplY3QgaXMgbm90IGZyZWVkIGJl
Zm9yZSByZXR1cm5pbmcgdGhlCmVycm9yIGNvZGUsIGNhc3VpbmcgYSBtZW1vcnkgbGVhay4K
CkZpeCB0aGlzIGJ5IGZyZWVpbmcgdGhlIGFjcGlfcGFyc2Vfb2JqZWN0IHdoZW4gZW5jb3Vu
dGVyaW5nIGFuCmVycm9yLgoKU2lnbmVkLW9mZi1ieTogQXJtaW4gV29sZiA8V19Bcm1pbkBn
bXguZGU+Ci0tLQogZHJpdmVycy9hY3BpL2FjcGljYS9wc2FyZ3MuYyB8IDggKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2FjcGkvYWNwaWNhL3BzYXJncy5jIGIvZHJpdmVycy9hY3BpL2FjcGljYS9wc2FyZ3MuYwpp
bmRleCA0MjJjMDc0ZWQyODkuLjdkZWJmZDVjZTBkOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9h
Y3BpL2FjcGljYS9wc2FyZ3MuYworKysgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL3BzYXJncy5j
CkBAIC04MjAsNiArODIwLDEwIEBAIGFjcGlfcHNfZ2V0X25leHRfYXJnKHN0cnVjdCBhY3Bp
X3dhbGtfc3RhdGUgKndhbGtfc3RhdGUsCiAJCQkgICAgYWNwaV9wc19nZXRfbmV4dF9uYW1l
cGF0aCh3YWxrX3N0YXRlLCBwYXJzZXJfc3RhdGUsCiAJCQkJCQkgICAgICBhcmcsCiAJCQkJ
CQkgICAgICBBQ1BJX05PVF9NRVRIT0RfQ0FMTCk7CisJCQlpZiAoQUNQSV9GQUlMVVJFKHN0
YXR1cykpIHsKKwkJCQlhY3BpX3BzX2ZyZWVfb3AoYXJnKTsKKwkJCQlyZXR1cm5fQUNQSV9T
VEFUVVMoc3RhdHVzKTsKKwkJCX0KIAkJfSBlbHNlIHsKIAkJCS8qIFNpbmdsZSBjb21wbGV4
IGFyZ3VtZW50LCBub3RoaW5nIHJldHVybmVkICovCiAKQEAgLTg1NCw2ICs4NTgsMTAgQEAg
YWNwaV9wc19nZXRfbmV4dF9hcmcoc3RydWN0IGFjcGlfd2Fsa19zdGF0ZSAqd2Fsa19zdGF0
ZSwKIAkJCSAgICBhY3BpX3BzX2dldF9uZXh0X25hbWVwYXRoKHdhbGtfc3RhdGUsIHBhcnNl
cl9zdGF0ZSwKIAkJCQkJCSAgICAgIGFyZywKIAkJCQkJCSAgICAgIEFDUElfUE9TU0lCTEVf
TUVUSE9EX0NBTEwpOworCQkJaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKSB7CisJCQkJYWNw
aV9wc19mcmVlX29wKGFyZyk7CisJCQkJcmV0dXJuX0FDUElfU1RBVFVTKHN0YXR1cyk7CisJ
CQl9CiAKIAkJCWlmIChhcmctPmNvbW1vbi5hbWxfb3Bjb2RlID09IEFNTF9JTlRfTUVUSE9E
Q0FMTF9PUCkgewogCi0tIAoyLjM5LjIKCg==

--------------RPx3ATiTVOtWzCGGYaeaOQ6H--


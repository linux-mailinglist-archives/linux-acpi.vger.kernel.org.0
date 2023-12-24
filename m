Return-Path: <linux-acpi+bounces-2606-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA381D8BD
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Dec 2023 11:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48328B212B1
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Dec 2023 10:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000381C29;
	Sun, 24 Dec 2023 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLvXvtjr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D220F8
	for <linux-acpi@vger.kernel.org>; Sun, 24 Dec 2023 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d53297996so6973905e9.2
        for <linux-acpi@vger.kernel.org>; Sun, 24 Dec 2023 02:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703414367; x=1704019167; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vfPuq9Eb0zQl+QFgtjk3D4eY+IBZKQcX8q0AxPMiyUE=;
        b=BLvXvtjrbEeCoWzhC0FottlCbeBQeINxbkPPS8rOmb6O95XN9ovRhF4z/rqUumZ8cj
         QDvQ7s5lv5kufJ6N6fSIPlAJRk2N2W/r5kNRnZ1GNkBNx6KwiNG2L88xcRjIC9IPCGCW
         W3EbHrNrLdGkQbO7nXPpu2dU65WSJ+R5kra7xP+iKl/9D3FkSJyxogP+74wcKv1wJzhW
         knEH65ZoMRnjha6eA+KDJ8CmeJz04SRwiOzQfTT0+dSKJo5BP2ea//gTvczdEOUErXOa
         79rjUMBn9lIW+gM7ZEnWyPtaFiuzpl4lsGPtPIT+rlA6A6LRVW0UaDwh4sCihTsE0Ime
         ZzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703414367; x=1704019167;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfPuq9Eb0zQl+QFgtjk3D4eY+IBZKQcX8q0AxPMiyUE=;
        b=TDuSrLBGHGz42M6dT2TxY2gcRhAMbuC6M62kkw3anVdiAY/18gOjmAwW46sE9KIxjc
         DfPy+Af8WlBUE9Qkw8k4olnNuk9AsZGwNilOW9+jB5XGoaKE+M9eCyanjwM2gRUfw9FJ
         CEMy/OzGTATRDuTvxgFibqGkIDf2dmnWeqaHFSWPmpMiEjhQ4WwBz5oCOm/uWgqimREv
         CeklJZwK2lcahym++KXemAG/8OtyuxOhtiBdn24LeH/BIPFuNQWkiJE6gBEjxRBlVTZW
         ucgu3tYR8qlvTvBJtDcR98CMLr+oBHBn2i6chV+mjSBCCc0BVhAwT8oYwP7ttml9s+HS
         ahfw==
X-Gm-Message-State: AOJu0YzqDyWHz4hkch9TRa2/hX/YA6wPYpziVBZdhrXnSoGjT2+bzYez
	0C2vMySa7nLWuxD9JxjvS+7WoVtmp/YYysDgJIpCu+Qh3A==
X-Google-Smtp-Source: AGHT+IFyfcP3DUJrhYmTqck+cdi7vTpuHtidJMLVoSs+ZgTLz6GlJqFh6sbzm0eThhK4Y2buv96+LnXzcAbICiJCuko=
X-Received: by 2002:a05:600c:1d89:b0:40d:1ec2:9503 with SMTP id
 p9-20020a05600c1d8900b0040d1ec29503mr2162537wms.135.1703414366395; Sun, 24
 Dec 2023 02:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Benjamin_R=C3=A9veill=C3=A9?= <benjamin.reveille@gmail.com>
Date: Sun, 24 Dec 2023 11:39:15 +0100
Message-ID: <CAKFSxTdXam9X3SuFOunfwBkgkPZie8DidMrvS7V3946HQxv_9w@mail.gmail.com>
Subject: New blacklist entry for acpi=copy_dsdt
To: linux-acpi@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000370aa4060d3f1045"

--000000000000370aa4060d3f1045
Content-Type: multipart/alternative; boundary="000000000000370aa2060d3f1043"

--000000000000370aa2060d3f1043
Content-Type: text/plain; charset="UTF-8"

Please find attached the dmidecode.txt of my laptop that was having acpi
issues (no battery detected upon resume from hibernation [or sleep])
leading the the following indications in dmesg:

[  173.488162] ACPI BIOS Error (bug): The DSDT has been corrupted or
replaced - old, new headers below (20230628/tbutils-87)
[  173.488169] ACPI: DSDT 0x0000000000000000 00DA9E (v02 ALASKA A M I
 01072009 INTL 20160930)
[  173.488174] ACPI: A M  0x0000000000000000 002049 (v09 ??INTL 0?? \xa0L2
 50505C15 BA?? 50555C15)
[  173.488177] ACPI Error: Please send DMI info to
linux-acpi@vger.kernel.org
               If system does not work as expected, please boot with
acpi=copy_dsdt (20230628/tbutils-94)


Adding acpi=copy_dsdt to grub boot command line has indeed solved the issue.


Regards,

Benjamin

--000000000000370aa2060d3f1043
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Please find attached the dmidecode.txt of my laptop t=
hat was having acpi issues (no battery detected upon=C2=A0resume from hiber=
nation [or sleep]) leading the the following=C2=A0indications in dmesg:=C2=
=A0</div><div><br></div><blockquote style=3D"margin:0 0 0 40px;border:none;=
padding:0px"><div>[ =C2=A0173.488162] ACPI BIOS Error (bug): The DSDT has b=
een corrupted or replaced - old, new headers below (20230628/tbutils-87)</d=
iv>[ =C2=A0173.488169] ACPI: DSDT 0x0000000000000000 00DA9E (v02 ALASKA A M=
 I =C2=A0 =C2=A001072009 INTL 20160930)<br>[ =C2=A0173.488174] ACPI: A M =
=C2=A00x0000000000000000 002049 (v09 ??INTL 0?? \xa0L2 =C2=A050505C15 BA?? =
50555C15)<br>[ =C2=A0173.488177] ACPI Error: Please send DMI info to <a hre=
f=3D"mailto:linux-acpi@vger.kernel.org">linux-acpi@vger.kernel.org</a><br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If system does not w=
ork as expected, please boot with acpi=3Dcopy_dsdt (20230628/tbutils-94)</b=
lockquote><div><br></div><div>Adding=C2=A0acpi=3Dcopy_dsdt to grub boot com=
mand line has indeed solved the issue.<br></div><div><br></div><div><br></d=
iv><div>Regards,</div><div><br></div><div>Benjamin</div></div>

--000000000000370aa2060d3f1043--
--000000000000370aa4060d3f1045
Content-Type: text/plain; charset="US-ASCII"; name="dmidecode.txt"
Content-Disposition: attachment; filename="dmidecode.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lqjcx5u20>
X-Attachment-Id: f_lqjcx5u20

IyBkbWlkZWNvZGUgMy41CkdldHRpbmcgU01CSU9TIGRhdGEgZnJvbSBzeXNmcy4KU01CSU9TIDMu
Mi4wIHByZXNlbnQuClRhYmxlIGF0IDB4NzlFRUYwMDAuCgpIYW5kbGUgMHgwMDAwLCBETUkgdHlw
ZSAwLCAyNiBieXRlcwpCSU9TIEluZm9ybWF0aW9uCglWZW5kb3I6IEFtZXJpY2FuIE1lZ2F0cmVu
ZHMgSW5jLgoJVmVyc2lvbjogVjAuNS4wX1AxUzBNMkUwRjNMNkIwVDBQMkcwMEEwVTBEMjE2XzM2
NkItdGltaW5nCglSZWxlYXNlIERhdGU6IDA2LzA2LzIwMjAKCUFkZHJlc3M6IDB4RjAwMDAKCVJ1
bnRpbWUgU2l6ZTogNjQga0IKCVJPTSBTaXplOiA0OTI4IGtCCglDaGFyYWN0ZXJpc3RpY3M6CgkJ
UENJIGlzIHN1cHBvcnRlZAoJCUJJT1MgaXMgdXBncmFkZWFibGUKCQlCSU9TIHNoYWRvd2luZyBp
cyBhbGxvd2VkCgkJQm9vdCBmcm9tIENEIGlzIHN1cHBvcnRlZAoJCVNlbGVjdGFibGUgYm9vdCBp
cyBzdXBwb3J0ZWQKCQlCSU9TIFJPTSBpcyBzb2NrZXRlZAoJCUVERCBpcyBzdXBwb3J0ZWQKCQk1
LjI1Ii8xLjIgTUIgZmxvcHB5IHNlcnZpY2VzIGFyZSBzdXBwb3J0ZWQgKGludCAxM2gpCgkJMy41
Ii83MjAga0IgZmxvcHB5IHNlcnZpY2VzIGFyZSBzdXBwb3J0ZWQgKGludCAxM2gpCgkJMy41Ii8y
Ljg4IE1CIGZsb3BweSBzZXJ2aWNlcyBhcmUgc3VwcG9ydGVkIChpbnQgMTNoKQoJCVByaW50IHNj
cmVlbiBzZXJ2aWNlIGlzIHN1cHBvcnRlZCAoaW50IDVoKQoJCVNlcmlhbCBzZXJ2aWNlcyBhcmUg
c3VwcG9ydGVkIChpbnQgMTRoKQoJCVByaW50ZXIgc2VydmljZXMgYXJlIHN1cHBvcnRlZCAoaW50
IDE3aCkKCQlBQ1BJIGlzIHN1cHBvcnRlZAoJCVVTQiBsZWdhY3kgaXMgc3VwcG9ydGVkCgkJQklP
UyBib290IHNwZWNpZmljYXRpb24gaXMgc3VwcG9ydGVkCgkJVGFyZ2V0ZWQgY29udGVudCBkaXN0
cmlidXRpb24gaXMgc3VwcG9ydGVkCgkJVUVGSSBpcyBzdXBwb3J0ZWQKCUJJT1MgUmV2aXNpb246
IDAuNQoKSGFuZGxlIDB4MDAwMSwgRE1JIHR5cGUgMSwgMjcgYnl0ZXMKU3lzdGVtIEluZm9ybWF0
aW9uCglNYW51ZmFjdHVyZXI6IFVOT1dIWQoJUHJvZHVjdCBOYW1lOiBZMTNHMDEwUzRFSQoJVmVy
c2lvbjogMS4wCglTZXJpYWwgTnVtYmVyOiBJRlAwMjQwMDYxNDMKCVVVSUQ6IDgyZDk4ODUyLTli
MTktMTFlYS1hNmViLTIyOTMyZDlkYTIwOAoJV2FrZS11cCBUeXBlOiBQb3dlciBTd2l0Y2gKCVNL
VSBOdW1iZXI6IFkxM0cwMTBTNEVJCglGYW1pbHk6IEVkdWNhdGlvbgoKSGFuZGxlIDB4MDAwMiwg
RE1JIHR5cGUgMiwgMTUgYnl0ZXMKQmFzZSBCb2FyZCBJbmZvcm1hdGlvbgoJTWFudWZhY3R1cmVy
OiBVTk9XSFkKCVByb2R1Y3QgTmFtZTogTUcxMzMoRU1fSUcxMTZfMzY2Ql9WMi4wKQoJVmVyc2lv
bjogMS4wCglTZXJpYWwgTnVtYmVyOiBEZWZhdWx0IHN0cmluZwoJQXNzZXQgVGFnOiBEZWZhdWx0
IHN0cmluZwoJRmVhdHVyZXM6CgkJQm9hcmQgaXMgYSBob3N0aW5nIGJvYXJkCgkJQm9hcmQgaXMg
cmVwbGFjZWFibGUKCUxvY2F0aW9uIEluIENoYXNzaXM6IERlZmF1bHQgc3RyaW5nCglDaGFzc2lz
IEhhbmRsZTogMHgwMDAzCglUeXBlOiBNb3RoZXJib2FyZAoJQ29udGFpbmVkIE9iamVjdCBIYW5k
bGVzOiAwCgpIYW5kbGUgMHgwMDAzLCBETUkgdHlwZSAzLCAyMiBieXRlcwpDaGFzc2lzIEluZm9y
bWF0aW9uCglNYW51ZmFjdHVyZXI6IERlZmF1bHQgc3RyaW5nCglUeXBlOiBOb3RlYm9vawoJTG9j
azogTm90IFByZXNlbnQKCVZlcnNpb246IERlZmF1bHQgc3RyaW5nCglTZXJpYWwgTnVtYmVyOiBE
ZWZhdWx0IHN0cmluZwoJQXNzZXQgVGFnOiBEZWZhdWx0IHN0cmluZwoJQm9vdC11cCBTdGF0ZTog
U2FmZQoJUG93ZXIgU3VwcGx5IFN0YXRlOiBTYWZlCglUaGVybWFsIFN0YXRlOiBTYWZlCglTZWN1
cml0eSBTdGF0dXM6IE5vbmUKCU9FTSBJbmZvcm1hdGlvbjogMHgwMDAwMDAwMAoJSGVpZ2h0OiBV
bnNwZWNpZmllZAoJTnVtYmVyIE9mIFBvd2VyIENvcmRzOiAxCglDb250YWluZWQgRWxlbWVudHM6
IDAKCVNLVSBOdW1iZXI6IERlZmF1bHQgc3RyaW5nCgpIYW5kbGUgMHgwMDA4LCBETUkgdHlwZSA4
LCA5IGJ5dGVzClBvcnQgQ29ubmVjdG9yIEluZm9ybWF0aW9uCglJbnRlcm5hbCBSZWZlcmVuY2Ug
RGVzaWduYXRvcjogSjFBMQoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCUV4dGVybmFs
IFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBQUzJNb3VzZQoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6
IFBTLzIKCVBvcnQgVHlwZTogTW91c2UgUG9ydAoKSGFuZGxlIDB4MDAwOSwgRE1JIHR5cGUgOCwg
OSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERl
c2lnbmF0b3I6IEoxQTEKCUludGVybmFsIENvbm5lY3RvciBUeXBlOiBOb25lCglFeHRlcm5hbCBS
ZWZlcmVuY2UgRGVzaWduYXRvcjogS2V5Ym9hcmQKCUV4dGVybmFsIENvbm5lY3RvciBUeXBlOiBQ
Uy8yCglQb3J0IFR5cGU6IEtleWJvYXJkIFBvcnQKCkhhbmRsZSAweDAwMEEsIERNSSB0eXBlIDgs
IDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBE
ZXNpZ25hdG9yOiBKMkExCglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJRXh0ZXJuYWwg
UmVmZXJlbmNlIERlc2lnbmF0b3I6IFRWIE91dAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE1p
bmkgQ2VudHJvbmljcyBUeXBlLTE0CglQb3J0IFR5cGU6IE90aGVyCgpIYW5kbGUgMHgwMDBCLCBE
TUkgdHlwZSA4LCA5IGJ5dGVzClBvcnQgQ29ubmVjdG9yIEluZm9ybWF0aW9uCglJbnRlcm5hbCBS
ZWZlcmVuY2UgRGVzaWduYXRvcjogSjJBMkEKCUludGVybmFsIENvbm5lY3RvciBUeXBlOiBOb25l
CglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogQ09NIEEKCUV4dGVybmFsIENvbm5lY3Rv
ciBUeXBlOiBEQi05IG1hbGUKCVBvcnQgVHlwZTogU2VyaWFsIFBvcnQgMTY1NTBBIENvbXBhdGli
bGUKCkhhbmRsZSAweDAwMEMsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5m
b3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKMkEyQgoJSW50ZXJuYWwg
Q29ubmVjdG9yIFR5cGU6IE5vbmUKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBWaWRl
bwoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IERCLTE1IGZlbWFsZQoJUG9ydCBUeXBlOiBWaWRl
byBQb3J0CgpIYW5kbGUgMHgwMDBELCBETUkgdHlwZSA4LCA5IGJ5dGVzClBvcnQgQ29ubmVjdG9y
IEluZm9ybWF0aW9uCglJbnRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogSjNBMQoJSW50ZXJu
YWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBV
U0IxCglFeHRlcm5hbCBDb25uZWN0b3IgVHlwZTogQWNjZXNzIEJ1cyAoVVNCKQoJUG9ydCBUeXBl
OiBVU0IKCkhhbmRsZSAweDAwMEUsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3Ig
SW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKM0ExCglJbnRlcm5h
bCBDb25uZWN0b3IgVHlwZTogTm9uZQoJRXh0ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IFVT
QjIKCUV4dGVybmFsIENvbm5lY3RvciBUeXBlOiBBY2Nlc3MgQnVzIChVU0IpCglQb3J0IFR5cGU6
IFVTQgoKSGFuZGxlIDB4MDAwRiwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJ
bmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IEozQTEKCUludGVybmFs
IENvbm5lY3RvciBUeXBlOiBOb25lCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogVVNC
MwoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IEFjY2VzcyBCdXMgKFVTQikKCVBvcnQgVHlwZTog
VVNCCgpIYW5kbGUgMHgwMDEwLCBETUkgdHlwZSA4LCA5IGJ5dGVzClBvcnQgQ29ubmVjdG9yIElu
Zm9ybWF0aW9uCglJbnRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogSjlBMSAtIFRQTSBIRFIK
CUludGVybmFsIENvbm5lY3RvciBUeXBlOiBPdGhlcgoJRXh0ZXJuYWwgUmVmZXJlbmNlIERlc2ln
bmF0b3I6IE5vdCBTcGVjaWZpZWQKCUV4dGVybmFsIENvbm5lY3RvciBUeXBlOiBOb25lCglQb3J0
IFR5cGU6IE90aGVyCgpIYW5kbGUgMHgwMDExLCBETUkgdHlwZSA4LCA5IGJ5dGVzClBvcnQgQ29u
bmVjdG9yIEluZm9ybWF0aW9uCglJbnRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogSjlDMSAt
IFBDSUUgRE9DS0lORyBDT05OCglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogT3RoZXIKCUV4dGVy
bmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBOb3QgU3BlY2lmaWVkCglFeHRlcm5hbCBDb25uZWN0
b3IgVHlwZTogTm9uZQoJUG9ydCBUeXBlOiBPdGhlcgoKSGFuZGxlIDB4MDAxMiwgRE1JIHR5cGUg
OCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwgUmVmZXJlbmNl
IERlc2lnbmF0b3I6IEoyQjMgLSBDUFUgRkFOCglJbnRlcm5hbCBDb25uZWN0b3IgVHlwZTogT3Ro
ZXIKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBOb3QgU3BlY2lmaWVkCglFeHRlcm5h
bCBDb25uZWN0b3IgVHlwZTogTm9uZQoJUG9ydCBUeXBlOiBPdGhlcgoKSGFuZGxlIDB4MDAxMywg
RE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJSW50ZXJuYWwg
UmVmZXJlbmNlIERlc2lnbmF0b3I6IEo2QzIgLSBFWFQgSERNSQoJSW50ZXJuYWwgQ29ubmVjdG9y
IFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmll
ZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRs
ZSAweDAwMTQsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24K
CUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKM0MxIC0gR01DSCBGQU4KCUludGVybmFs
IENvbm5lY3RvciBUeXBlOiBPdGhlcgoJRXh0ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IE5v
dCBTcGVjaWZpZWQKCUV4dGVybmFsIENvbm5lY3RvciBUeXBlOiBOb25lCglQb3J0IFR5cGU6IE90
aGVyCgpIYW5kbGUgMHgwMDE1LCBETUkgdHlwZSA4LCA5IGJ5dGVzClBvcnQgQ29ubmVjdG9yIElu
Zm9ybWF0aW9uCglJbnRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogSjFEMSAtIElUUAoJSW50
ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRv
cjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlw
ZTogT3RoZXIKCkhhbmRsZSAweDAwMTYsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0
b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKOUUyIC0gTURD
IElOVFBTUgoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVu
Y2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5v
bmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMTcsIERNSSB0eXBlIDgsIDkgYnl0ZXMK
UG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9y
OiBKOUU0IC0gTURDIElOVFBTUgoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRl
cm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVj
dG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMTgsIERNSSB0eXBl
IDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5j
ZSBEZXNpZ25hdG9yOiBKOUUzIC0gTFBDIEhPVCBET0NLSU5HCglJbnRlcm5hbCBDb25uZWN0b3Ig
VHlwZTogT3RoZXIKCUV4dGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBOb3QgU3BlY2lmaWVk
CglFeHRlcm5hbCBDb25uZWN0b3IgVHlwZTogTm9uZQoJUG9ydCBUeXBlOiBPdGhlcgoKSGFuZGxl
IDB4MDAxOSwgRE1JIHR5cGUgOCwgOSBieXRlcwpQb3J0IENvbm5lY3RvciBJbmZvcm1hdGlvbgoJ
SW50ZXJuYWwgUmVmZXJlbmNlIERlc2lnbmF0b3I6IEo5RTEgLSBTQ0FOIE1BVFJJWAoJSW50ZXJu
YWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjog
Tm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTog
T3RoZXIKCkhhbmRsZSAweDAwMUEsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3Ig
SW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKOUcxIC0gTFBDIFNJ
REUgQkFORAoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVu
Y2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5v
bmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMUIsIERNSSB0eXBlIDgsIDkgYnl0ZXMK
UG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9y
OiBKOEYxIC0gVU5JRklFRAoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5h
bCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9y
IFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMUMsIERNSSB0eXBlIDgs
IDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVyZW5jZSBE
ZXNpZ25hdG9yOiBKNkYxIC0gTFZEUwoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglF
eHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29u
bmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAwMUQsIERNSSB0
eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVybmFsIFJlZmVy
ZW5jZSBEZXNpZ25hdG9yOiBKMkYxIC0gTEFJIEZBTgoJSW50ZXJuYWwgQ29ubmVjdG9yIFR5cGU6
IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNpZmllZAoJRXh0
ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhhbmRsZSAweDAw
MUUsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRpb24KCUludGVy
bmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKMkcxIC0gR0ZYIFZJRAoJSW50ZXJuYWwgQ29ubmVj
dG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjogTm90IFNwZWNp
ZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTogT3RoZXIKCkhh
bmRsZSAweDAwMUYsIERNSSB0eXBlIDgsIDkgYnl0ZXMKUG9ydCBDb25uZWN0b3IgSW5mb3JtYXRp
b24KCUludGVybmFsIFJlZmVyZW5jZSBEZXNpZ25hdG9yOiBKMUc2IC0gQUMgSkFDSwoJSW50ZXJu
YWwgQ29ubmVjdG9yIFR5cGU6IE90aGVyCglFeHRlcm5hbCBSZWZlcmVuY2UgRGVzaWduYXRvcjog
Tm90IFNwZWNpZmllZAoJRXh0ZXJuYWwgQ29ubmVjdG9yIFR5cGU6IE5vbmUKCVBvcnQgVHlwZTog
T3RoZXIKCkhhbmRsZSAweDAwMjAsIERNSSB0eXBlIDEwLCA2IGJ5dGVzCk9uIEJvYXJkIERldmlj
ZSBJbmZvcm1hdGlvbgoJVHlwZTogVmlkZW8KCVN0YXR1czogRW5hYmxlZAoJRGVzY3JpcHRpb246
ICAgIFRvIEJlIEZpbGxlZCBCeSBPLkUuTS4KCkhhbmRsZSAweDAwMjEsIERNSSB0eXBlIDExLCA1
IGJ5dGVzCk9FTSBTdHJpbmdzCglTdHJpbmcgMTogRGVmYXVsdCBzdHJpbmcKCkhhbmRsZSAweDAw
MjIsIERNSSB0eXBlIDEyLCA1IGJ5dGVzClN5c3RlbSBDb25maWd1cmF0aW9uIE9wdGlvbnMKCU9w
dGlvbiAxOiBFRFNZWUIKCkhhbmRsZSAweDAwMjMsIERNSSB0eXBlIDE2LCAyMyBieXRlcwpQaHlz
aWNhbCBNZW1vcnkgQXJyYXkKCUxvY2F0aW9uOiBTeXN0ZW0gQm9hcmQgT3IgTW90aGVyYm9hcmQK
CVVzZTogU3lzdGVtIE1lbW9yeQoJRXJyb3IgQ29ycmVjdGlvbiBUeXBlOiBOb25lCglNYXhpbXVt
IENhcGFjaXR5OiAzMiBHQgoJRXJyb3IgSW5mb3JtYXRpb24gSGFuZGxlOiBOb3QgUHJvdmlkZWQK
CU51bWJlciBPZiBEZXZpY2VzOiAyCgpIYW5kbGUgMHgwMDI0LCBETUkgdHlwZSAxOSwgMzEgYnl0
ZXMKTWVtb3J5IEFycmF5IE1hcHBlZCBBZGRyZXNzCglTdGFydGluZyBBZGRyZXNzOiAweDAwMDAw
MDAwMDAwCglFbmRpbmcgQWRkcmVzczogMHgwMDBGRkZGRkZGRgoJUmFuZ2UgU2l6ZTogNCBHQgoJ
UGh5c2ljYWwgQXJyYXkgSGFuZGxlOiAweDAwMjMKCVBhcnRpdGlvbiBXaWR0aDogMgoKSGFuZGxl
IDB4MDAyNSwgRE1JIHR5cGUgMTcsIDg0IGJ5dGVzCk1lbW9yeSBEZXZpY2UKCUFycmF5IEhhbmRs
ZTogMHgwMDIzCglFcnJvciBJbmZvcm1hdGlvbiBIYW5kbGU6IE5vdCBQcm92aWRlZAoJVG90YWwg
V2lkdGg6IDE2IGJpdHMKCURhdGEgV2lkdGg6IDE2IGJpdHMKCVNpemU6IDIgR0IKCUZvcm0gRmFj
dG9yOiBESU1NCglTZXQ6IE5vbmUKCUxvY2F0b3I6IEExX0RJTU0wCglCYW5rIExvY2F0b3I6IEEx
X0JBTkswCglUeXBlOiBMUEREUjQKCVR5cGUgRGV0YWlsOiBTeW5jaHJvbm91cwoJU3BlZWQ6IDI0
MDAgTVQvcwoJTWFudWZhY3R1cmVyOiBBQkNECglTZXJpYWwgTnVtYmVyOiAxMjM0CglBc3NldCBU
YWc6IDk4NzY1NDMyMTAKCVBhcnQgTnVtYmVyOiAxMjM0NTY3ODkwMTIzNDU2NzgKCVJhbms6IFVu
a25vd24KCUNvbmZpZ3VyZWQgTWVtb3J5IFNwZWVkOiAyNDAwIE1UL3MKCU1pbmltdW0gVm9sdGFn
ZTogMS4xIFYKCU1heGltdW0gVm9sdGFnZTogMS41IFYKCUNvbmZpZ3VyZWQgVm9sdGFnZTogMS4x
IFYKCU1lbW9yeSBUZWNobm9sb2d5OiBEUkFNCglNZW1vcnkgT3BlcmF0aW5nIE1vZGUgQ2FwYWJp
bGl0eTogVm9sYXRpbGUgbWVtb3J5CglGaXJtd2FyZSBWZXJzaW9uOiBOb3QgU3BlY2lmaWVkCglN
b2R1bGUgTWFudWZhY3R1cmVyIElEOiBVbmtub3duCglNb2R1bGUgUHJvZHVjdCBJRDogVW5rbm93
bgoJTWVtb3J5IFN1YnN5c3RlbSBDb250cm9sbGVyIE1hbnVmYWN0dXJlciBJRDogVW5rbm93bgoJ
TWVtb3J5IFN1YnN5c3RlbSBDb250cm9sbGVyIFByb2R1Y3QgSUQ6IFVua25vd24KCU5vbi1Wb2xh
dGlsZSBTaXplOiBOb25lCglWb2xhdGlsZSBTaXplOiAyIEdCCglDYWNoZSBTaXplOiBOb25lCglM
b2dpY2FsIFNpemU6IE5vbmUKCkhhbmRsZSAweDAwMjYsIERNSSB0eXBlIDIwLCAzNSBieXRlcwpN
ZW1vcnkgRGV2aWNlIE1hcHBlZCBBZGRyZXNzCglTdGFydGluZyBBZGRyZXNzOiAweDAwMDAwMDAw
MDAwCglFbmRpbmcgQWRkcmVzczogMHgwMDA3RkZGRkZGRgoJUmFuZ2UgU2l6ZTogMiBHQgoJUGh5
c2ljYWwgRGV2aWNlIEhhbmRsZTogMHgwMDI1CglNZW1vcnkgQXJyYXkgTWFwcGVkIEFkZHJlc3Mg
SGFuZGxlOiAweDAwMjQKCVBhcnRpdGlvbiBSb3cgUG9zaXRpb246IFVua25vd24KCUludGVybGVh
dmUgUG9zaXRpb246IDEKCUludGVybGVhdmVkIERhdGEgRGVwdGg6IDIKCkhhbmRsZSAweDAwMjcs
IERNSSB0eXBlIDE3LCA4NCBieXRlcwpNZW1vcnkgRGV2aWNlCglBcnJheSBIYW5kbGU6IDB4MDAy
MwoJRXJyb3IgSW5mb3JtYXRpb24gSGFuZGxlOiBOb3QgUHJvdmlkZWQKCVRvdGFsIFdpZHRoOiAx
NiBiaXRzCglEYXRhIFdpZHRoOiAxNiBiaXRzCglTaXplOiAyIEdCCglGb3JtIEZhY3RvcjogRElN
TQoJU2V0OiBOb25lCglMb2NhdG9yOiBBMV9ESU1NMQoJQmFuayBMb2NhdG9yOiBBMV9CQU5LMQoJ
VHlwZTogTFBERFI0CglUeXBlIERldGFpbDogU3luY2hyb25vdXMKCVNwZWVkOiAyNDAwIE1UL3MK
CU1hbnVmYWN0dXJlcjogQUJDRAoJU2VyaWFsIE51bWJlcjogMTIzNAoJQXNzZXQgVGFnOiA5ODc2
NTQzMjEwCglQYXJ0IE51bWJlcjogMTIzNDU2Nzg5MDEyMzQ1Njc4CglSYW5rOiBVbmtub3duCglD
b25maWd1cmVkIE1lbW9yeSBTcGVlZDogMjQwMCBNVC9zCglNaW5pbXVtIFZvbHRhZ2U6IDEuMSBW
CglNYXhpbXVtIFZvbHRhZ2U6IDEuNSBWCglDb25maWd1cmVkIFZvbHRhZ2U6IDEuMSBWCglNZW1v
cnkgVGVjaG5vbG9neTogRFJBTQoJTWVtb3J5IE9wZXJhdGluZyBNb2RlIENhcGFiaWxpdHk6IFZv
bGF0aWxlIG1lbW9yeQoJRmlybXdhcmUgVmVyc2lvbjogTm90IFNwZWNpZmllZAoJTW9kdWxlIE1h
bnVmYWN0dXJlciBJRDogVW5rbm93bgoJTW9kdWxlIFByb2R1Y3QgSUQ6IFVua25vd24KCU1lbW9y
eSBTdWJzeXN0ZW0gQ29udHJvbGxlciBNYW51ZmFjdHVyZXIgSUQ6IFVua25vd24KCU1lbW9yeSBT
dWJzeXN0ZW0gQ29udHJvbGxlciBQcm9kdWN0IElEOiBVbmtub3duCglOb24tVm9sYXRpbGUgU2l6
ZTogTm9uZQoJVm9sYXRpbGUgU2l6ZTogMiBHQgoJQ2FjaGUgU2l6ZTogTm9uZQoJTG9naWNhbCBT
aXplOiBOb25lCgpIYW5kbGUgMHgwMDI4LCBETUkgdHlwZSAyMCwgMzUgYnl0ZXMKTWVtb3J5IERl
dmljZSBNYXBwZWQgQWRkcmVzcwoJU3RhcnRpbmcgQWRkcmVzczogMHgwMDA4MDAwMDAwMAoJRW5k
aW5nIEFkZHJlc3M6IDB4MDAwRkZGRkZGRkYKCVJhbmdlIFNpemU6IDIgR0IKCVBoeXNpY2FsIERl
dmljZSBIYW5kbGU6IDB4MDAyNwoJTWVtb3J5IEFycmF5IE1hcHBlZCBBZGRyZXNzIEhhbmRsZTog
MHgwMDI0CglQYXJ0aXRpb24gUm93IFBvc2l0aW9uOiBVbmtub3duCglJbnRlcmxlYXZlIFBvc2l0
aW9uOiAyCglJbnRlcmxlYXZlZCBEYXRhIERlcHRoOiAyCgpIYW5kbGUgMHgwMDI5LCBETUkgdHlw
ZSAzMiwgMjAgYnl0ZXMKU3lzdGVtIEJvb3QgSW5mb3JtYXRpb24KCVN0YXR1czogTm8gZXJyb3Jz
IGRldGVjdGVkCgpIYW5kbGUgMHgwMDJBLCBETUkgdHlwZSA0MywgMzEgYnl0ZXMKVFBNIERldmlj
ZQoJVmVuZG9yIElEOiBDVE5JCglTcGVjaWZpY2F0aW9uIFZlcnNpb246IDIuMAoJRmlybXdhcmUg
UmV2aXNpb246IDQwMy4wCglEZXNjcmlwdGlvbjogSU5URUwKCUNoYXJhY3RlcmlzdGljczoKCQlG
YW1pbHkgY29uZmlndXJhYmxlIHZpYSBwbGF0Zm9ybSBzb2Z0d2FyZSBzdXBwb3J0CglPRU0tc3Bl
Y2lmaWMgSW5mb3JtYXRpb246IDB4MDAwMDAwMDAKCkhhbmRsZSAweDAwMkYsIERNSSB0eXBlIDcs
IDI3IGJ5dGVzCkNhY2hlIEluZm9ybWF0aW9uCglTb2NrZXQgRGVzaWduYXRpb246IENQVSBJbnRl
cm5hbCBMMQoJQ29uZmlndXJhdGlvbjogRW5hYmxlZCwgTm90IFNvY2tldGVkLCBMZXZlbCAxCglP
cGVyYXRpb25hbCBNb2RlOiBXcml0ZSBCYWNrCglMb2NhdGlvbjogSW50ZXJuYWwKCUluc3RhbGxl
ZCBTaXplOiAxOTMwIE1CCglNYXhpbXVtIFNpemU6IDEzMTIgR0IKCVN1cHBvcnRlZCBTUkFNIFR5
cGVzOgoJCVN5bmNocm9ub3VzCglJbnN0YWxsZWQgU1JBTSBUeXBlOiBTeW5jaHJvbm91cwoJU3Bl
ZWQ6IFVua25vd24KCUVycm9yIENvcnJlY3Rpb24gVHlwZTogUGFyaXR5CglTeXN0ZW0gVHlwZTog
T3RoZXIKCUFzc29jaWF0aXZpdHk6IE90aGVyCgpIYW5kbGUgMHgwMDMwLCBETUkgdHlwZSA3LCAy
NyBieXRlcwpDYWNoZSBJbmZvcm1hdGlvbgoJU29ja2V0IERlc2lnbmF0aW9uOiBDUFUgSW50ZXJu
YWwgTDIKCUNvbmZpZ3VyYXRpb246IEVuYWJsZWQsIE5vdCBTb2NrZXRlZCwgTGV2ZWwgMgoJT3Bl
cmF0aW9uYWwgTW9kZTogV3JpdGUgQmFjawoJTG9jYXRpb246IEludGVybmFsCglJbnN0YWxsZWQg
U2l6ZTogMTE0NTcyIEdCCglNYXhpbXVtIFNpemU6IDExNTIgR0IKCVN1cHBvcnRlZCBTUkFNIFR5
cGVzOgoJCVN5bmNocm9ub3VzCglJbnN0YWxsZWQgU1JBTSBUeXBlOiBTeW5jaHJvbm91cwoJU3Bl
ZWQ6IFVua25vd24KCUVycm9yIENvcnJlY3Rpb24gVHlwZTogU2luZ2xlLWJpdCBFQ0MKCVN5c3Rl
bSBUeXBlOiBVbmlmaWVkCglBc3NvY2lhdGl2aXR5OiAxNi13YXkgU2V0LWFzc29jaWF0aXZlCgpI
YW5kbGUgMHgwMDMxLCBETUkgdHlwZSA0LCA0OCBieXRlcwpQcm9jZXNzb3IgSW5mb3JtYXRpb24K
CVNvY2tldCBEZXNpZ25hdGlvbjogU09DS0VUIDAKCVR5cGU6IENlbnRyYWwgUHJvY2Vzc29yCglG
YW1pbHk6IENlbGVyb24KCU1hbnVmYWN0dXJlcjogSW50ZWwKCUlEOiBBMSAwNiAwNyAwMCBGRiBG
QiBFQiBCRgoJU2lnbmF0dXJlOiBUeXBlIDAsIEZhbWlseSA2LCBNb2RlbCAxMjIsIFN0ZXBwaW5n
IDEKCUZsYWdzOgoJCUZQVSAoRmxvYXRpbmctcG9pbnQgdW5pdCBvbi1jaGlwKQoJCVZNRSAoVmly
dHVhbCBtb2RlIGV4dGVuc2lvbikKCQlERSAoRGVidWdnaW5nIGV4dGVuc2lvbikKCQlQU0UgKFBh
Z2Ugc2l6ZSBleHRlbnNpb24pCgkJVFNDIChUaW1lIHN0YW1wIGNvdW50ZXIpCgkJTVNSIChNb2Rl
bCBzcGVjaWZpYyByZWdpc3RlcnMpCgkJUEFFIChQaHlzaWNhbCBhZGRyZXNzIGV4dGVuc2lvbikK
CQlNQ0UgKE1hY2hpbmUgY2hlY2sgZXhjZXB0aW9uKQoJCUNYOCAoQ01QWENIRzggaW5zdHJ1Y3Rp
b24gc3VwcG9ydGVkKQoJCUFQSUMgKE9uLWNoaXAgQVBJQyBoYXJkd2FyZSBzdXBwb3J0ZWQpCgkJ
U0VQIChGYXN0IHN5c3RlbSBjYWxsKQoJCU1UUlIgKE1lbW9yeSB0eXBlIHJhbmdlIHJlZ2lzdGVy
cykKCQlQR0UgKFBhZ2UgZ2xvYmFsIGVuYWJsZSkKCQlNQ0EgKE1hY2hpbmUgY2hlY2sgYXJjaGl0
ZWN0dXJlKQoJCUNNT1YgKENvbmRpdGlvbmFsIG1vdmUgaW5zdHJ1Y3Rpb24gc3VwcG9ydGVkKQoJ
CVBBVCAoUGFnZSBhdHRyaWJ1dGUgdGFibGUpCgkJUFNFLTM2ICgzNi1iaXQgcGFnZSBzaXplIGV4
dGVuc2lvbikKCQlDTEZTSCAoQ0xGTFVTSCBpbnN0cnVjdGlvbiBzdXBwb3J0ZWQpCgkJRFMgKERl
YnVnIHN0b3JlKQoJCUFDUEkgKEFDUEkgc3VwcG9ydGVkKQoJCU1NWCAoTU1YIHRlY2hub2xvZ3kg
c3VwcG9ydGVkKQoJCUZYU1IgKEZYU0FWRSBhbmQgRlhTVE9SIGluc3RydWN0aW9ucyBzdXBwb3J0
ZWQpCgkJU1NFIChTdHJlYW1pbmcgU0lNRCBleHRlbnNpb25zKQoJCVNTRTIgKFN0cmVhbWluZyBT
SU1EIGV4dGVuc2lvbnMgMikKCQlTUyAoU2VsZi1zbm9vcCkKCQlIVFQgKE11bHRpLXRocmVhZGlu
ZykKCQlUTSAoVGhlcm1hbCBtb25pdG9yIHN1cHBvcnRlZCkKCQlQQkUgKFBlbmRpbmcgYnJlYWsg
ZW5hYmxlZCkKCVZlcnNpb246IEludGVsKFIpIENlbGVyb24oUikgTjQxMDAgQ1BVIEAgMS4xMEdI
egoJVm9sdGFnZTogMS4yIFYKCUV4dGVybmFsIENsb2NrOiAxMDAgTUh6CglNYXggU3BlZWQ6IDI3
MDAgTUh6CglDdXJyZW50IFNwZWVkOiAxMTAwIE1IegoJU3RhdHVzOiBQb3B1bGF0ZWQsIEVuYWJs
ZWQKCVVwZ3JhZGU6IE90aGVyCglMMSBDYWNoZSBIYW5kbGU6IDB4MDAyRgoJTDIgQ2FjaGUgSGFu
ZGxlOiAweDAwMzAKCUwzIENhY2hlIEhhbmRsZTogTm90IFByb3ZpZGVkCglTZXJpYWwgTnVtYmVy
OiBOb3QgU3BlY2lmaWVkCglBc3NldCBUYWc6IEZpbGwgQnkgT0VNCglQYXJ0IE51bWJlcjogRmls
bCBCeSBPRU0KCUNvcmUgQ291bnQ6IDQKCUNvcmUgRW5hYmxlZDogNAoJVGhyZWFkIENvdW50OiA0
CglDaGFyYWN0ZXJpc3RpY3M6CgkJNjQtYml0IGNhcGFibGUKCkhhbmRsZSAweDAwMzIsIERNSSB0
eXBlIDQxLCAxMSBieXRlcwpPbmJvYXJkIERldmljZQoJUmVmZXJlbmNlIERlc2lnbmF0aW9uOiBP
bmJvYXJkIC0gUlRLIEV0aGVybmV0CglUeXBlOiBFdGhlcm5ldAoJU3RhdHVzOiBEaXNhYmxlZAoJ
VHlwZSBJbnN0YW5jZTogMQoJQnVzIEFkZHJlc3M6IDAwMDA6ZmY6MDAuMAoKSGFuZGxlIDB4MDAz
MywgRE1JIHR5cGUgNDEsIDExIGJ5dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWdu
YXRpb246IE9uYm9hcmQgLSBPdGhlcgoJVHlwZTogT3RoZXIKCVN0YXR1czogRW5hYmxlZAoJVHlw
ZSBJbnN0YW5jZTogMQoJQnVzIEFkZHJlc3M6IDAwMDA6MDA6MDAuMAoKSGFuZGxlIDB4MDAzNCwg
RE1JIHR5cGUgNDEsIDExIGJ5dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRp
b246IE9uYm9hcmQgLSBPdGhlcgoJVHlwZTogT3RoZXIKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJ
bnN0YW5jZTogMgoJQnVzIEFkZHJlc3M6IDAwMDA6MDA6MDAuMQoKSGFuZGxlIDB4MDAzNSwgRE1J
IHR5cGUgNDEsIDExIGJ5dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246
IE9uYm9hcmQgLSBWaWRlbwoJVHlwZTogVmlkZW8KCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0
YW5jZTogMQoJQnVzIEFkZHJlc3M6IDAwMDA6MDA6MDIuMAoKSGFuZGxlIDB4MDAzNiwgRE1JIHR5
cGUgNDEsIDExIGJ5dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246IE9u
Ym9hcmQgLSBPdGhlcgoJVHlwZTogT3RoZXIKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5j
ZTogMwoJQnVzIEFkZHJlc3M6IDAwMDA6MDA6MGQuMAoKSGFuZGxlIDB4MDAzNywgRE1JIHR5cGUg
NDEsIDExIGJ5dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246IE9uYm9h
cmQgLSBPdGhlcgoJVHlwZTogT3RoZXIKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTog
NAoJQnVzIEFkZHJlc3M6IDAwMDA6MDA6MGQuMgoKSGFuZGxlIDB4MDAzOCwgRE1JIHR5cGUgNDEs
IDExIGJ5dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246IE9uYm9hcmQg
LSBTb3VuZAoJVHlwZTogU291bmQKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTogMQoJ
QnVzIEFkZHJlc3M6IDAwMDA6MDA6MGUuMAoKSGFuZGxlIDB4MDAzOSwgRE1JIHR5cGUgNDEsIDEx
IGJ5dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246IE9uYm9hcmQgLSBP
dGhlcgoJVHlwZTogT3RoZXIKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTogNQoJQnVz
IEFkZHJlc3M6IDAwMDA6MDA6MGYuMAoKSGFuZGxlIDB4MDAzQSwgRE1JIHR5cGUgNDEsIDExIGJ5
dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246IE9uYm9hcmQgLSBTQVRB
CglUeXBlOiBTQVRBIENvbnRyb2xsZXIKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTog
MQoJQnVzIEFkZHJlc3M6IDAwMDA6MDA6MTIuMAoKSGFuZGxlIDB4MDAzQiwgRE1JIHR5cGUgNDEs
IDExIGJ5dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246IE9uYm9hcmQg
LSBPdGhlcgoJVHlwZTogT3RoZXIKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTogNgoJ
QnVzIEFkZHJlc3M6IDAwMDA6MDA6MTUuMAoKSGFuZGxlIDB4MDAzQywgRE1JIHR5cGUgNDEsIDEx
IGJ5dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246IE9uYm9hcmQgLSBP
dGhlcgoJVHlwZTogT3RoZXIKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTogNwoJQnVz
IEFkZHJlc3M6IDAwMDA6MDA6MTYuMAoKSGFuZGxlIDB4MDAzRCwgRE1JIHR5cGUgNDEsIDExIGJ5
dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246IE9uYm9hcmQgLSBPdGhl
cgoJVHlwZTogT3RoZXIKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTogOAoJQnVzIEFk
ZHJlc3M6IDAwMDA6MDA6MTYuMQoKSGFuZGxlIDB4MDAzRSwgRE1JIHR5cGUgNDEsIDExIGJ5dGVz
Ck9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246IE9uYm9hcmQgLSBPdGhlcgoJ
VHlwZTogT3RoZXIKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTogOQoJQnVzIEFkZHJl
c3M6IDAwMDA6MDA6MTYuMgoKSGFuZGxlIDB4MDAzRiwgRE1JIHR5cGUgNDEsIDExIGJ5dGVzCk9u
Ym9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246IE9uYm9hcmQgLSBPdGhlcgoJVHlw
ZTogT3RoZXIKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTogMTAKCUJ1cyBBZGRyZXNz
OiAwMDAwOjAwOjE2LjMKCkhhbmRsZSAweDAwNDAsIERNSSB0eXBlIDQxLCAxMSBieXRlcwpPbmJv
YXJkIERldmljZQoJUmVmZXJlbmNlIERlc2lnbmF0aW9uOiBPbmJvYXJkIC0gT3RoZXIKCVR5cGU6
IE90aGVyCglTdGF0dXM6IEVuYWJsZWQKCVR5cGUgSW5zdGFuY2U6IDExCglCdXMgQWRkcmVzczog
MDAwMDowMDoxNy4wCgpIYW5kbGUgMHgwMDQxLCBETUkgdHlwZSA0MSwgMTEgYnl0ZXMKT25ib2Fy
ZCBEZXZpY2UKCVJlZmVyZW5jZSBEZXNpZ25hdGlvbjogT25ib2FyZCAtIE90aGVyCglUeXBlOiBP
dGhlcgoJU3RhdHVzOiBFbmFibGVkCglUeXBlIEluc3RhbmNlOiAxMgoJQnVzIEFkZHJlc3M6IDAw
MDA6MDA6MTcuMQoKSGFuZGxlIDB4MDA0MiwgRE1JIHR5cGUgNDEsIDExIGJ5dGVzCk9uYm9hcmQg
RGV2aWNlCglSZWZlcmVuY2UgRGVzaWduYXRpb246IE9uYm9hcmQgLSBPdGhlcgoJVHlwZTogT3Ro
ZXIKCVN0YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTogMTMKCUJ1cyBBZGRyZXNzOiAwMDAw
OjAwOjE3LjIKCkhhbmRsZSAweDAwNDMsIERNSSB0eXBlIDQxLCAxMSBieXRlcwpPbmJvYXJkIERl
dmljZQoJUmVmZXJlbmNlIERlc2lnbmF0aW9uOiBPbmJvYXJkIC0gT3RoZXIKCVR5cGU6IE90aGVy
CglTdGF0dXM6IEVuYWJsZWQKCVR5cGUgSW5zdGFuY2U6IDE0CglCdXMgQWRkcmVzczogMDAwMDow
MDoxNy4zCgpIYW5kbGUgMHgwMDQ0LCBETUkgdHlwZSA0MSwgMTEgYnl0ZXMKT25ib2FyZCBEZXZp
Y2UKCVJlZmVyZW5jZSBEZXNpZ25hdGlvbjogT25ib2FyZCAtIE90aGVyCglUeXBlOiBPdGhlcgoJ
U3RhdHVzOiBFbmFibGVkCglUeXBlIEluc3RhbmNlOiAxNQoJQnVzIEFkZHJlc3M6IDAwMDA6MDA6
MTguMAoKSGFuZGxlIDB4MDA0NSwgRE1JIHR5cGUgNDEsIDExIGJ5dGVzCk9uYm9hcmQgRGV2aWNl
CglSZWZlcmVuY2UgRGVzaWduYXRpb246IE9uYm9hcmQgLSBPdGhlcgoJVHlwZTogT3RoZXIKCVN0
YXR1czogRW5hYmxlZAoJVHlwZSBJbnN0YW5jZTogMTYKCUJ1cyBBZGRyZXNzOiAwMDAwOjAwOjE4
LjEKCkhhbmRsZSAweDAwNDYsIERNSSB0eXBlIDQxLCAxMSBieXRlcwpPbmJvYXJkIERldmljZQoJ
UmVmZXJlbmNlIERlc2lnbmF0aW9uOiBPbmJvYXJkIC0gT3RoZXIKCVR5cGU6IE90aGVyCglTdGF0
dXM6IEVuYWJsZWQKCVR5cGUgSW5zdGFuY2U6IDE3CglCdXMgQWRkcmVzczogMDAwMDowMDoxOC4y
CgpIYW5kbGUgMHgwMDQ3LCBETUkgdHlwZSA0MSwgMTEgYnl0ZXMKT25ib2FyZCBEZXZpY2UKCVJl
ZmVyZW5jZSBEZXNpZ25hdGlvbjogT25ib2FyZCAtIE90aGVyCglUeXBlOiBPdGhlcgoJU3RhdHVz
OiBFbmFibGVkCglUeXBlIEluc3RhbmNlOiAxOAoJQnVzIEFkZHJlc3M6IDAwMDA6MDA6MTguMwoK
SGFuZGxlIDB4MDA0OCwgRE1JIHR5cGUgNDEsIDExIGJ5dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZl
cmVuY2UgRGVzaWduYXRpb246IE9uYm9hcmQgLSBPdGhlcgoJVHlwZTogT3RoZXIKCVN0YXR1czog
RW5hYmxlZAoJVHlwZSBJbnN0YW5jZTogMTkKCUJ1cyBBZGRyZXNzOiAwMDAwOjAwOjE5LjAKCkhh
bmRsZSAweDAwNDksIERNSSB0eXBlIDQxLCAxMSBieXRlcwpPbmJvYXJkIERldmljZQoJUmVmZXJl
bmNlIERlc2lnbmF0aW9uOiBPbmJvYXJkIC0gT3RoZXIKCVR5cGU6IE90aGVyCglTdGF0dXM6IEVu
YWJsZWQKCVR5cGUgSW5zdGFuY2U6IDIwCglCdXMgQWRkcmVzczogMDAwMDowMDoxOS4xCgpIYW5k
bGUgMHgwMDRBLCBETUkgdHlwZSA0MSwgMTEgYnl0ZXMKT25ib2FyZCBEZXZpY2UKCVJlZmVyZW5j
ZSBEZXNpZ25hdGlvbjogT25ib2FyZCAtIE90aGVyCglUeXBlOiBPdGhlcgoJU3RhdHVzOiBFbmFi
bGVkCglUeXBlIEluc3RhbmNlOiAyMQoJQnVzIEFkZHJlc3M6IDAwMDA6MDA6MTkuMgoKSGFuZGxl
IDB4MDA0QiwgRE1JIHR5cGUgNDEsIDExIGJ5dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2Ug
RGVzaWduYXRpb246IE9uYm9hcmQgLSBPdGhlcgoJVHlwZTogT3RoZXIKCVN0YXR1czogRW5hYmxl
ZAoJVHlwZSBJbnN0YW5jZTogMjIKCUJ1cyBBZGRyZXNzOiAwMDAwOjAwOjFjLjAKCkhhbmRsZSAw
eDAwNEMsIERNSSB0eXBlIDQxLCAxMSBieXRlcwpPbmJvYXJkIERldmljZQoJUmVmZXJlbmNlIERl
c2lnbmF0aW9uOiBPbmJvYXJkIC0gT3RoZXIKCVR5cGU6IE90aGVyCglTdGF0dXM6IEVuYWJsZWQK
CVR5cGUgSW5zdGFuY2U6IDIzCglCdXMgQWRkcmVzczogMDAwMDowMDoxZS4wCgpIYW5kbGUgMHgw
MDRELCBETUkgdHlwZSA0MSwgMTEgYnl0ZXMKT25ib2FyZCBEZXZpY2UKCVJlZmVyZW5jZSBEZXNp
Z25hdGlvbjogT25ib2FyZCAtIE90aGVyCglUeXBlOiBPdGhlcgoJU3RhdHVzOiBFbmFibGVkCglU
eXBlIEluc3RhbmNlOiAyNAoJQnVzIEFkZHJlc3M6IDAwMDA6MDA6MWYuMAoKSGFuZGxlIDB4MDA0
RSwgRE1JIHR5cGUgNDEsIDExIGJ5dGVzCk9uYm9hcmQgRGV2aWNlCglSZWZlcmVuY2UgRGVzaWdu
YXRpb246IE9uYm9hcmQgLSBPdGhlcgoJVHlwZTogT3RoZXIKCVN0YXR1czogRW5hYmxlZAoJVHlw
ZSBJbnN0YW5jZTogMjUKCUJ1cyBBZGRyZXNzOiAwMDAwOjAwOjFmLjEKCkhhbmRsZSAweDAwNEYs
IERNSSB0eXBlIDEzLCAyMiBieXRlcwpCSU9TIExhbmd1YWdlIEluZm9ybWF0aW9uCglMYW5ndWFn
ZSBEZXNjcmlwdGlvbiBGb3JtYXQ6IExvbmcKCUluc3RhbGxhYmxlIExhbmd1YWdlczogMQoJCWVu
fFVTfGlzbzg4NTktMQoJQ3VycmVudGx5IEluc3RhbGxlZCBMYW5ndWFnZTogZW58VVN8aXNvODg1
OS0xCgpIYW5kbGUgMHgwMDUwLCBETUkgdHlwZSA5LCAxOSBieXRlcwpTeXN0ZW0gU2xvdCBJbmZv
cm1hdGlvbgoJRGVzaWduYXRpb246IEo3SDEKCVR5cGU6IHg0IFBDSSBFeHByZXNzIDIgeDQKCUN1
cnJlbnQgVXNhZ2U6IEluIFVzZQoJTGVuZ3RoOiBTaG9ydAoJSUQ6IDAKCUNoYXJhY3RlcmlzdGlj
czoKCQkzLjMgViBpcyBwcm92aWRlZAoJCU9wZW5pbmcgaXMgc2hhcmVkCgkJUE1FIHNpZ25hbCBp
cyBzdXBwb3J0ZWQKCUJ1cyBBZGRyZXNzOiAwMDAwOjAwOjEzLjAKCURhdGEgQnVzIFdpZHRoOiAx
MAoJUGVlciBEZXZpY2VzOiAwCgpIYW5kbGUgMHgwMDUxLCBETUkgdHlwZSA5LCAxOSBieXRlcwpT
eXN0ZW0gU2xvdCBJbmZvcm1hdGlvbgoJRGVzaWduYXRpb246IEo4SDEKCVR5cGU6IHgyIFBDSSBF
eHByZXNzIDIgeDIKCUN1cnJlbnQgVXNhZ2U6IEF2YWlsYWJsZQoJTGVuZ3RoOiBTaG9ydAoJSUQ6
IDEKCUNoYXJhY3RlcmlzdGljczoKCQkzLjMgViBpcyBwcm92aWRlZAoJCU9wZW5pbmcgaXMgc2hh
cmVkCgkJUE1FIHNpZ25hbCBpcyBzdXBwb3J0ZWQKCUJ1cyBBZGRyZXNzOiAwMDAwOjAwOjE0LjEK
CURhdGEgQnVzIFdpZHRoOiA5CglQZWVyIERldmljZXM6IDAKCkhhbmRsZSAweDAwNTIsIERNSSB0
eXBlIDEyNywgNCBieXRlcwpFbmQgT2YgVGFibGUKCg==
--000000000000370aa4060d3f1045--


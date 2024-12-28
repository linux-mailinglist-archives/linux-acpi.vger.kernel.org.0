Return-Path: <linux-acpi+bounces-10316-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623EF9FD91A
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Dec 2024 06:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D918916321F
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Dec 2024 05:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BCD2BAEC;
	Sat, 28 Dec 2024 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.com header.i=gazo11@mail.com header.b="QwtR7vug"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09B8C1E;
	Sat, 28 Dec 2024 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735365050; cv=none; b=CfZVQ0t4uUPncXjp2fwgZMeNpLXxlBh9lEvYYBAJayKqH3NIjoUXCAtxpJsrUdaeeAOYraZ94SYzG7fDFudyu0Fu8iRssw9bquOusKzZ7qD1zpKZU6+H2boo5XmbgCSh1MMFHVo9vM70ryLoqDFiDpoaBoPZ1RhITJBztRt651E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735365050; c=relaxed/simple;
	bh=HFTJPQV5ggm83ycWBf5cOP9Tytf+kZAH3u3ncZtf6AU=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=aNiwNMk6sFX2zZ0LuAYCA8yczY3+g+17efy2B6+eDJfVJb8oiTgrVON0YsMQhyi46ijCgwIos+ohlgKq0jRf/foutmJEFDvvJpK/ILBPfjUZf9M6szq2IUstruSDc3Y6KFXRelbkxDTzFdyPY5Pl4oJ47vc0rDrztZagKbwMPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com; spf=pass smtp.mailfrom=mail.com; dkim=pass (2048-bit key) header.d=mail.com header.i=gazo11@mail.com header.b=QwtR7vug; arc=none smtp.client-ip=74.208.4.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.com;
	s=s1089575; t=1735365047; x=1735969847; i=gazo11@mail.com;
	bh=HFTJPQV5ggm83ycWBf5cOP9Tytf+kZAH3u3ncZtf6AU=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QwtR7vugZx4stmJhzlvnACulzxLgFgLdDP3fVYdJZtvOX13Vp4zTOvgypwN9Gkuc
	 ALV/hzQnIiv5WJ9rvHXT+EWVxn/FMxbXy7B4UXgKP8giRsr+P1nU4PCHvHcsMBG2N
	 sbOw/0Un5GnnM/jlSskiQuFmas6afYhwUWfwNQKLvI7Po0yfH1W2CHwqnkaeBfg8l
	 XAdA6NPnQ7O4MNabdLzmWrapD2MNr1WLxctWioWXy+Buu/wwZ821zYOYWFt6WYhKS
	 HVTflREEkqSnHP3GBCa8nqiYF8BcFIY58C+0E9owOj2gzvn86cj0vL8/UM59LYQzp
	 3AePBlykO0JB5RXlBQ==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [77.137.74.199] ([77.137.74.199]) by web-mail.mail.com
 (3c-app-mailcom-lxa14.server.lan [10.76.45.15]) (via HTTP); Sat, 28 Dec
 2024 06:50:47 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-13f8fb07-bab6-4449-acb7-77c6d708cc37-1735365047718@3c-app-mailcom-lxa14>
From: Gustavo Azor <gazo11@mail.com>
To: bugzilla-daemon@kernel.org, jwrdegoede@fedoraproject.org,
 linux-acpi@vger.kernel.org, stable@vger.kernel.org, rafael@kernel.org
Subject: [PATCH] ACPI: resource: Add Asus Vivobook X1504VAP to
 irq1_level_low_skip_override[]
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Dec 2024 06:50:47 +0100
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:zG6UA10U/FGznR7TmVQ98PT/4NhvJwQj2g9YvHX7chZTi7HFgC12zdh6YMPt3A0Dve8s9
 Br7uLv3iKnF0cLFY5AH8khmVuk8u1Qe3v+mH7iDfjxKIil3XpOU00Gus7EzRtHVdfWk4t0IGaulC
 XbAGtUvl/KhzMhF3Ol/P2jpqMXsSTv8uGcTOwlK51pszsXBsqrNnjzUhpC9HCOVJQP4P0dfsvk8i
 UPQV+s1rkTiJHOpkPITQm4UymrQTYAgfSEuPEQ2AW+aEGD5r5MT3QAQGZbV3KIDdXxGVDGlib3+z
 P4=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tXtRA69sQ7g=;2cnjwoH0nRWhhDcoT1d3FzvSlTw
 U3CVJpLCsxv+hHPG+CoJH7p0sy9wpDlUC/Be4TnuL8ZznCfNxtW8a9E6r6ofPpZdrUDAnfQYT
 5bOli26Cm2vSCbVXAgVX2foevcI3UuTlmU8PPC/TPEz25ATGR54PLYrJTLECcnT2MXPzXjWdf
 fL6UYYbRL3pbyLMyw4r2F93gpgA0JcoRyZayB/GqYRV7rQKBjrCM+TE9A0/R4w5WadsTHkcqX
 yYF2HcYNA5kZStw/gVt0UkH62/ngqERrDKbQ+pq7dK9X0ioDpjXy32NQKJiDVhHwPS/oA3ixv
 KK1l3tHCKNoe1SCGeqsLg2h59KbOYJU8zWfo8N6BaW0mfGZMywT1/Er0BfWmPkyiO6yW4SVn8
 2lcg7dIgjn+TEDy7KZBKkF2Zy0Lm+p3O8ndEpxgNtKLdtBkCm6YgFHYh7kudShAtfAVYKQj/0
 niIGHSjrSJPPUA9Dujzx1lzbln86T8w/XFONe6YoqPPvUlJW0JX3wa5Za7EVu/6cn2aqyp6HY
 8V+b2aYoR16MXVEfbyvD+WlTblcWCbA7SN9TGnFRFyUkahkLhMDP9xIUCP3yCzhiWvuiU4HBQ
 M09Se0ncaOFpT0akpuy60+zWHFWvIQoQhtQw+SIL5YwBAhFOTE9VtnViucbPACNPYSMtprPCn
 C9XGj+e1GhL2kFLro+lO6sCybufeOgkqpwtBLRpa8A2zPLxLzIozWX1j2lUxpnL2EWKuuP1Ck
 tnYolpxWL9p632Vk9SFBRj8aD7npE1HeQVzzji6qIgWi8ljPbAr7PqEkJsK1dHlibBUJQlFbD
 l6ZbuB/T+BO8dEkYvzB9O0RWBQGcqF2KZuZLqEPteMGuXYYfwGaPJrkF+Jl9YGwEEVJLtfdHI
 KKoqwnV/SFysyyUjurTA1cLMZV6+nhmYPZXE=



=C2=A0

Estimated people:
Seems to me, I browse drivers/acpi/resources=2Ec: the patch was not includ=
ed in kernel versions stable 6=2E12=2E7 or long term 6=2E6=2E68=2E
I hope will be include in mainline 6=2E13=2E-rc5 to inform if work in the =
ASUS Vivobook 15 X1504VAP_X1504VA keyboard=2E
I have not idea how work with git diff or compiling kernels to try the pat=
ch, and need to try in installed kernel=2E
Thanks=2ERegards=2E

Sent:=C2=A0Friday, December 20, 2024 at 8:23 PM
From:=C2=A0bugzilla-daemon@kernel=2Eorg
To:=C2=A0gazo11@mail=2Ecom
Subject:=C2=A0[Bug 219224] Laptop Internal Keyboard not working on ASUS Vi=
voBook E1404GA on ubuntu 24=2E04=2E
https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecgi?id=3D219224

--- Comment #11 from Hans de Goede (jwrdegoede@fedoraproject=2Eorg) ---
(In reply to gazo11 from comment #10)
> Hello I have the same problem for dmidecode:
>
>
> System Information
> Manufacturer: ASUSTeK COMPUTER INC=2E
> Product Name: ASUS Vivobook 15 X1504VAP_X1504VA
> Version: 1=2E0
> Serial Number: S1N0CV02L86302G
> UUID: cdc508f0-d3f1-f743-bce4-5eb9d4c06fda
> Wake-up Type: Power Switch
> SKU Number:
> Family: ASUS Vivobook 15
>
> Its possible to get this model listed in future kernels? Thanks!

Thank you for reporting this, I've submitted a patch to add this to the
irq1_level_low_skip_override[] list:

https://lore=2Ekernel=2Eorg/linux-acpi/20241220181352=2E25974-1-hdegoede@r=
edhat=2Ecom/[https://lore=2Ekernel=2Eorg/linux-acpi/20241220181352=2E25974-=
1-hdegoede@redhat=2Ecom/]

--
You may reply to this email to add a comment=2E

You are receiving this mail because:
You are on the CC list for the bug=2E


Return-Path: <linux-acpi+bounces-5623-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8528BC281
	for <lists+linux-acpi@lfdr.de>; Sun,  5 May 2024 18:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1F91F21102
	for <lists+linux-acpi@lfdr.de>; Sun,  5 May 2024 16:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F3E374CB;
	Sun,  5 May 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="aJ2j6YTJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70307E54C
	for <linux-acpi@vger.kernel.org>; Sun,  5 May 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714926329; cv=none; b=b4AdaMvVk394ER2ATLAi89tb26uFW4rivOp+s/POJIYgxV4KA8XLxP8shnfys2152D46t8GAVIUr8Kz69DHwKYVRup/D+0qiThvNp4lEB9zqWns60wwUWr/Q//Zc7cxADzvJKARqdXy752tk3nIdnyA8oC6kwM328hAXklMORZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714926329; c=relaxed/simple;
	bh=1yjhyz4/U9X/mXeKGtXL1ay2wOny6fLfWOS0tDpsVNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=JG7+g6aKa/D3KoYSZisXkki5qphdJt3VgA7eoTjgTDpqih/OelChItht31AbuPyUVJvLg/gZcEZmhJVjsMa7VgYJ7CRSubSOOivukOznCK6BVKCt0IQLcmZKlk4POTVIVajcz5N7q59EEU3ZmSGLYgtAN9VFsquXGDaREGZkPB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=aJ2j6YTJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714926318; x=1715531118; i=w_armin@gmx.de;
	bh=IT0O+6ilUv1J4vaAmK/zTCA0q7uqJpQC891T0YfDu18=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aJ2j6YTJsemSsmPIp06OcEZNq5+Ck+Z7o7Zj581uDW6GuY4EiVDLkn10LnIA0Z2V
	 0IUWqh1bcEgOa5mWCxYVsZGqtlW61MWkvHOL1vrqjOsoGsX92KcmwAtPHJPYf18/P
	 QCXosaO9TFjE51/JdOW7KJc6wESf6Iq0rQn9LBS0LhS1BWFW1knheZIRXF0BHAkSn
	 AlRlKnnpYg5WYCwZvyE97fldlG5/C0Y1fMveTcpxj7FiSqWRuhrM7XFlrJtSATfjV
	 //UAbIxlaInxsAmZE93K0rKAVYfRGgG65gqBAIDG5JTLkARsFdQs5U7UACCJCI+s+
	 WmMlD99yzDxxXJvfOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGVx-1sHkDT2FPZ-00P3aI; Sun, 05
 May 2024 18:25:18 +0200
Message-ID: <2cd5a3d5-ed29-48c7-bb70-e660aff5c0d2@gmx.de>
Date: Sun, 5 May 2024 18:25:08 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 32-bit versus 64-bit ACPI tables
To: "Billie Alsup (balsup)" <balsup@cisco.com>
References: <SJ0PR11MB662464447DF707057BF43F97D9192@SJ0PR11MB6624.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Len Brown <lenb@kernel.org>
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <SJ0PR11MB662464447DF707057BF43F97D9192@SJ0PR11MB6624.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ceetVtYB7niVheNL4PUZO0gvBhvU8SW/YFVGBDVP6ARKsrcsyUr
 DquRh+XAwytfSgbyUPYyVAe4+n0CoQzBBJwIKwsDg9SZJk93GynvwyT6M/9tNwNyF0K+/XU
 fgT6zwE1AOOR03Ie7dz230sALlIwW/3/tmg1och6Wkj+5i9BRNaBJxA2MafmFkqKiCGgYpB
 qJtJ4Fi8nDkQBDv0j5Kow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Blu19G9dKKk=;WDGhjIYkRTU12hnp8aEsLozYBzh
 K/owKRfayraXThlJc4UF9TLVW7WxrQV55j+nOwrBIhihOv99JOQ0GuqSO0BkdRn070hx0oJ5O
 lGnMef+MyVpH39kN4Wgl4YMJhjvXMqazFmG9uIjRGJFZVW517pEcPmASbt8P6Dr61BAcXOnvI
 ZNZuiAt/OhfjTkOCyzep+/vNeUVX90Qn5EEkreITFEXFC8FSxzgJOSRdNUQPaNvevyeIiUtRu
 mINkPdNkSxuQUG4JxrnfcCI360UKmGPy2oJe53kU6pqMc+lezP892nVeTIFcSjHLPpS5Gsgiu
 RYm7hWDysvvTc+AF2w6wzoz0NDU7sjkCzMM7P2THHuXfiU0Ba1OQQ4MWbQwsZeO3vCmUcNUdh
 uXUV23mM4IJ9nXFaa47zyr0jeo7Rf9o+beBOMWbt3HIw+AaZSvNQToGsMWGat8ZbVPkzRDOHK
 sv8jxHzAFmc7I/sFvIk43fHV4MtthmS5571GQOneVNgCtHv/IK3zALh88M5Fro6l7AonCrV+h
 HHI7CtHg97FyVw9NBbrtdOYFF3AVV07GKM3rybUdoHCS0O5NClcHmdpsyek+E/W/MK9je5/Oz
 Ih+zgHSpJJwWEun2170cdZr3hnuMaTm3n0YoL7bL67x2E32uKRjm5pcxraXN4BTBEXuVOwbEm
 sjiiQh5LGQYBFNAo5K+3Szj+Mdy3OMDaV87H4szGItqgxWYbJGkhab9m7FqCBAdC6V2KoYrJ2
 d+yoo2gMtZvODwTM8FwYsDXN4rw4cyjmbDkjkUItDwOEKWXNBUMLpMAKVvDPNDJV/ArdZAnWS
 bW40esbgkc1luiZdO4AxFcexYBGZj0Ks4TTXcsyhFSvGM=

Am 01.01.70 um 01:00 schrieb :

> My hardware comes with a DSDT with 32-bit tables, however I would like to add a
> 64-bit table via SSDT.  Although, my SSDT compiles and loads successfully, the
> kernel truncates my 64-bit values because it apparently remembers that the DSDT
> used 32-bit tables.  Is there a way to have a 64-bit SSDT, to augment a 32-bit DSDT?
>
> I don't quite understand the reason for truncating the SSDT values.  The original
> code (from 2005!) warns that this is potentially a serious problem in the ACPI
> table(s) due to (possibly) buggy ASL compilers.  However, in my case, I want
> to explicitly have a 64-bit SSDT, and set the ComplianceRevision to 2 specifically
> to support 64-bit integers.  But alas, they are still truncated due to a global
> setting of
>
>                  acpi_gbl_integer_bit_width = 32;
>                  acpi_gbl_integer_nybble_width = 8;
>                  acpi_gbl_integer_byte_width = 4;
>
> versus having table specific settings.  Is there a workaround for this issue?
>
> It would be quite painful (both for me, and for customers) to get new firmware
> with a higher ComplianceRevision in the DSDT.  I wonder if there is an acceptable
> alternative.  For example, is truncation really required still (are we still dealing with
> buggy ASL compilers after 19 more years have elapsed?). Should there be a
> kernel command line parameter, or a kernel config option, to disable truncation?
> Should these acpi_gbl_integer_* variables be table specific, rather than global?
>
> I would appreciate any insights or advice you can offer me. Thanks in advance!
>
> Some additional references:
>
> 1. truncation occurs in file drivers/acpi/acpica/exutils.c
>      function acpi_ex_truncate_for32bit_table
> 2. initial setting of the globals occurs in file drivers/acpi/utilities/utmisc.c
>      function acpi_ut_set_integer_width

Hi,

the ACPI specification says that the integer length for _both_ DSDT and SSDT tables
is controlled by the revision field of the DSDT, so your 32-bit DSDT prevents your
SSDT from using 64-bit integers.

The only solution for this would be to not use 64-bit values inside your SSDT, is
there a reason why you absolutely need 64-bit integers in your DSDT?

Thanks,
Armin Wolf



Return-Path: <linux-acpi+bounces-9721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A453B9D5514
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 22:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C6BEB21802
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 21:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CE91CB50D;
	Thu, 21 Nov 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag4bYnak"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593783CDA
	for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226262; cv=none; b=pjtiML5B960mVhLloZyvGelau40EvJOSuz9CWS7f+V0Fuwnu2OnN5kXK2ZyP6mjddagu5TYW8FLvqehWVZfFx3GQEEe+KtollmOEBbUsPMsuEutaTN6RdNvznOQSqmGY/cWtAUxgxwCYWYDSm6GreYHMAOFejwstmZhgG6ELImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226262; c=relaxed/simple;
	bh=+E59SYt+oa5I7rqH3tzM9vOcs7Wa37imLj0PyX5vT/E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bN374V0ZEELQCTu/T+nvesEubtIxPHHNgccKGojI4937Tk/H9UoOrXvLBQFDUc/axqs6AoClTHFWhaXvQURzDbqRMH9cExGETj3mbrJXVz/iOCFf4EpURll2qOw3kx/SaICdvWw4Bq2lv1s4nxw4kEojWzt+VGZVKrHjqZxjMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag4bYnak; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21160c8af77so2079155ad.0
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2024 13:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732226260; x=1732831060; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmOokTuP/fJ6jwIk7UOaIJtZJR2/KMotEWrE3az6aPs=;
        b=ag4bYnakD/98EEp2nWPxDqfLyXpLUIpcp+uf4OSKA4zU+HTbQgPAktr2J4BJn+BE7l
         3XZ8hwicexWdN2D24U/2HQyscM/zRJJzueuOTJMPVmEspVZ9humOP9fCSwckEKRquoE5
         47984VgT7KjsttRmod2weOkJwhlVjw5QDCenLhjyOXPIP5YYeP+RqrOflAuy30keEVZz
         77NgtCsFCHNZUow4EAlnlYHJ54mLZ56fQQtDs0oZRwhgnm5QxDyengNXrC1Gx8d6ETqH
         FggLXgaJEZgtTUgnqZHgVSeAnOEciJMbZwwTrzjjq9MCQWeVa3HzWbEJxHl6cHx/ReVj
         Fe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732226260; x=1732831060;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmOokTuP/fJ6jwIk7UOaIJtZJR2/KMotEWrE3az6aPs=;
        b=dbiowG3GF4dDonCcocGjKapBEyBLM5acCkQe+kGBaeUiIZEgi1XigKZY+lQ6/euQxj
         JspJIQ27l6kyA8OeJC2r7KSig6r6gdRmesrYyLCqkpqtOz8GFakU6IiVvfCUKx9ShE5M
         NbzMkxtLHyHlbHy9F9M+C+FY7vdLoI9yY8wbJsVgj4dmjaZG9wBdRZgHMYPtUOkH5zJs
         CEcfvIsLaZGRFCit/5ol3zOpbagI1I1tDigIkQR8zIwaIaBIM9Fsc7bjU3ZnmwERH0y4
         kh9r5ilnmT3JRhLtx9pmEypYhOflhPC1Wsgl9BAOOgkkYkx/8SVzLPV3UnylmcLAzwNm
         d2lw==
X-Gm-Message-State: AOJu0YyeYF3bf7DINVZ9GdX1rsB4C/a4X9ZuDSskv+KHVg2JChNqVARi
	M7nxUPYPc/9uFXf+gj8T8D+NBV7n3MWK8oYxcHBcr5UHh7+VUpPJ
X-Gm-Gg: ASbGncsy5/hhc3cFadNVodNEbL6GNY/1eovp4c/r0KihPEuKrKn7wb0RgZyjNTH0wGQ
	29QoKhzXpAfRS/wiGqgYIir4G/U0dKzhgwkb9oeKROUCAzfhHWh7YjJOlqIn2JXdfAQW94Mevnv
	8bnFvMT0HmRnIJo11QiocAKEy8SKSX6Kf+8pnWS+9oGEESfQiS0tqY571h0WTsnaQAB9rT9EYm+
	my4Gj9agVMvu7yLQzoZgDxd5E0q1lgDfAh3/aSlHVxIp3DGZEfnR9O9WkluzQ==
X-Google-Smtp-Source: AGHT+IELdPCv8qT4RIVizbEADxfZkB92GFK9CNnbfkeEH6wxGPejG2hatbOnqP9XovYuelLTbGcbkg==
X-Received: by 2002:a17:903:230a:b0:211:ff09:57f9 with SMTP id d9443c01a7336-2129f29359amr3761575ad.13.1732226260063;
        Thu, 21 Nov 2024 13:57:40 -0800 (PST)
Received: from smtpclient.apple ([2406:4440:0:105::41:a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc21a50sm2997015ad.230.2024.11.21.13.57.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2024 13:57:39 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v3 2/7] ACPI: scan: Extract CSI-2 connection graph from
 _CRS
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <2927980.e9J7NaK4W3@kreacher>
Date: Fri, 22 Nov 2024 05:57:24 +0800
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C20272A3-65B5-4AAD-B6AD-0B93A95C5D93@gmail.com>
References: <4542595.LvFx2qVVIh@kreacher> <2927980.e9J7NaK4W3@kreacher>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3826.200.121)

2023=E5=B9=B411=E6=9C=887=E6=97=A5 00:09=EF=BC=8CRafael J. Wysocki =
<rjw@rjwysocki.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>  +static acpi_status acpi_bus_check_add(acpi_handle handle, bool =
first_pass,
>   				      struct acpi_device **adev_p)
>   {
>   	struct acpi_device *device =3D acpi_fetch_acpi_dev(handle);
>  @@ -2054,9 +2059,25 @@ static acpi_status acpi_bus_check_add(ac
>   		if (acpi_device_should_be_hidden(handle))
>   			return AE_OK;
>  =20
>  -		/* Bail out if there are dependencies. */
>  -		if (acpi_scan_check_dep(handle, check_dep) > 0)
>  -			return AE_CTRL_DEPTH;
>  +		if (first_pass) {
>  +			acpi_mipi_check_crs_csi2(handle);
>  +
>  +			/* Bail out if there are dependencies. */
>  +			if (acpi_scan_check_dep(handle) > 0) {
>  +				/*
>  +				 * The entire CSI-2 connection graph =
needs to be
>  +				 * extracted before any drivers or scan =
handlers
>  +				 * are bound to struct device objects, =
so scan
>  +				 * _CRS CSI-2 resource descriptors for =
all
>  +				 * devices below the current handle.
>  +				 */
>  +				acpi_walk_namespace(ACPI_TYPE_DEVICE, =
handle,
>  +						    ACPI_UINT32_MAX,
>  +						    =
acpi_scan_check_crs_csi2_cb,
>  +						    NULL, NULL, NULL);
>  +				return AE_CTRL_DEPTH;
>  +			}
>  +		}
>  =20
>   		fallthrough;
>   	case ACPI_TYPE_ANY:	/* for ACPI_ROOT_OBJECT */
>=20

Hi, I'd like to report some issues caused by this patch. Correct me if =
I'm wrong
since I'm not expert on ACPI. Before this patch, properties of ACPI =
devices with
_DEP relationship declared were evaluated after the initialization of =
the
depending devices, i.e. the execution of handler->attach(). With this =
patch,
_CRS of all the ACPI devices are evaluated to check if the device =
contains a
CSI2 resource, regardless of the declaration of _DEP relationship. The
evaluation of _CRS is even before _STA and other methods indicating the =
status
of the device.

This has caused some issues in certain scenarios, where the DSDT =
contains legacy
devices, which requires reading IO ports to form the result of its _CRS. =
An
example of such a legacy device is declared in the DSDT is as below:

    Device (LPT)
    {
        Name (_HID, EisaId ("PNP0400") /* Standard LPT Parallel Port */)
        Name (_UID, 0x02)  // _UID: Unique ID
        Name (_DDN, "LPT1")  // _DDN: DOS Device Name
        Name (_DEP, Package (0x01)  // _DEP: Dependencies
        {
            \_SB.PCI0
        })
        OperationRegion (ITE1, SystemIO, 0x2E, 0x02)
        Field (ITE1, ByteAcc, NoLock, Preserve) {INDX, 8,   DATA, 8}
        IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
        {
            // Omitting some declarations of fields
            IOAH,   8,
            IOAL,   8,
        }
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource =
Settings
        {
            Name (BUF0, ResourceTemplate ()
            {
                IO (Decode16,
                    0x0378,             // Range Minimum
                    0x0378,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    _Y01)
                IRQ (Level, ActiveLow, Exclusive, _Y02)
                    {7}
            })
            CreateByteField (BUF0, \LPT._CRS._Y01._MIN, IOLO)
            CreateByteField (BUF0, 0x03, IOHI)
            CreateByteField (BUF0, \LPT._CRS._Y01._MAX, IORL)
            CreateByteField (BUF0, 0x05, IORH)
            CreateByteField (BUF0, \LPT._CRS._Y01._LEN, LEN1)
            CreateByteField (BUF0, \LPT._CRS._Y02._INT, IRQL)=20
           =20
            IOLO =3D IOAL /* \LPT_.IOAL */
            IORL =3D IOAL /* \LPT_.IOAL */
            IOHI =3D IOAH /* \LPT_.IOAH */
            IORH =3D IOAH /* \LPT_.IOAH */
            // Omitting some assignments and calculations
           =20
            Return (BUF0)
        }
    }

On non-x86 platforms, IO ports are implemented using MMIO. The memory is
remapped in the initialization of the PCI root, using its QWordIO =
resource
declared in its _CRS, in acpi_pci_root_remap_iospace(). Before the
initialization of the PCI root, reads and writes of the IO ports will =
result in
accessing memory region which is not mapped.

Before this patch, adding a _DEP of Package(){PCI0} to these legacy =
devices will
postpone the initialization of these devices after the PCI root, solving =
the
above problem. After this patch, however, the evaluation of _CRS =
regardless of
_DEP declarations causes accessing IO ports before they are ready.

I've checked the ACPI spec, and it states that ``OSPM must guarantee =
that the
following operation regions are always accessible: SystemIO operation =
regions"
and ``Since the region types above are permanently available, no _REG =
methods
are required, nor will OSPM evaluate any _REG methods that appear in the =
same
scope as the operation region declaration(s) of these types". It seems =
that
from the view of the AML codes in the DSDT, it can never know when the =
IO ports
are ready, and it is impossible for Linux on non-x86 platforms to ensure =
IO
ports are always accessible.

I wonder if there would be a better solution to this problem.

Cheers,

Miao Wang=


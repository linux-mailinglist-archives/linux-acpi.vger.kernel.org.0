Return-Path: <linux-acpi+bounces-3424-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F8851C64
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 19:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2F82B2C02A
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 18:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C38C46436;
	Mon, 12 Feb 2024 17:57:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167CA46549
	for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760678; cv=none; b=J5MVtAzDHf9Zl7KJ4LBZV5PuUZVGpRl5qIb/vjZEaQPB5HQG51ngYUt6WeduTiQhAXR8wAkwqm5KRmWKRyqc4sysbEGnhzet0vmoNAqmtmnMIzm59OGjp60IdpsMICYtKpH9Escj94SUbe2sjagJsnjEPPMMiMh4rodxfAa+Lyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760678; c=relaxed/simple;
	bh=JcjbV8Lwuc0w5tnT8E/LK/fVQw9FbVoIT6pWIaNXvJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcGTHO0jAJqsYUAfRJkXRRdHJBO5JFXMPaEWt7+y+q4zF9miYZi97rX+uDhVK4ialGmKSLg/oNb9fcRCHOtQkRFZhMFOmcjIdeSyduy1mvtC3MPnn+zt+o25V6wjM82qhKFm561Vvuh5mBHwQlTBMrk2SqBX2fRkh5IurbmOVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e1242f8500so160913a34.0
        for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 09:57:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707760676; x=1708365476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHW5Bcs5iq62Iv4N6QSf+LgTAxMiQAUQcIezbXgtk/w=;
        b=DQWqBp0M3vP4tBVlvls1NvR5J2RShtF2K2K/LLD70MStQe/1+V6krBPkNufINjVYWg
         j5wkXdhRsLoqhvrQTnyhUIYBz7l5Ol2oyFMmo15pWvwVHjteJAbDiMW1XkAeGaXiTz4z
         4zhftZ/mtETt5icWSWMGg0sj6A3oI08lC1krs741BH6eJbvKkk9oYQKHYcB2VMK0HzXF
         FmEFjjI9KtE3eMmmReM805mKC24V8NHMsr99yZl4lNSaWLajm9Yg5IjfS+BALHHLXAst
         GTXAtFYnf9EnT+U/bVZy+lzLRo7puLkI4uPM08DlKbtHFC9iIkZ6Wi26vheOUsXXKxNK
         7itA==
X-Forwarded-Encrypted: i=1; AJvYcCVvNY0pPGRN//Keh8ayscjM2Wot/bz49f8F07ndzcj5wNexQdc0V8YFQUEpnOOlrzRd4orcQp3r8SUuHLRk0jVtPJAfxOTYBPcIDg==
X-Gm-Message-State: AOJu0YwaPM/PkwcZFtM2Wfha4TP4qvTrI3+nOFio+tfMFwVlXqzxEUBj
	+uN9w0/iBEzpm1YDZlssOGUJyWaCYAKMc0j5m2AgujE8SuuOOVRf/wY8ofMvYhweDyY+9m6lAD2
	BYBW0ROpMpI1N4Lnb19Wx03iqNK1rx9yD
X-Google-Smtp-Source: AGHT+IGIqoy8gJXLhdR4ZuANh5lx/ItptVJhTDwSyPlbkkbjWpEkVNHtjBktWT+bLJNImTATnK/gwmaw3q/t7OaPbPk=
X-Received: by 2002:a4a:ca0d:0:b0:599:e8ff:66d9 with SMTP id
 w13-20020a4aca0d000000b00599e8ff66d9mr5588216ooq.1.1707760676080; Mon, 12 Feb
 2024 09:57:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207005908.32598-1-wentong.wu@intel.com>
In-Reply-To: <20240207005908.32598-1-wentong.wu@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 18:57:44 +0100
Message-ID: <CAJZ5v0g+bQd_KyDDTGxR3BiN4WidfNi319qhuDzOT=NaDKZV=A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Defer enumeration of devices with a _DEP
 pointing to IVSC device
To: Wentong Wu <wentong.wu@intel.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 2:01=E2=80=AFAM Wentong Wu <wentong.wu@intel.com> wr=
ote:
>
> Inside IVSC, switching ownership requires an interface with two
> different hardware modules, ACE and CSI. The software interface
> to these modules is based on Intel MEI framework. Usually mei
> client devices are dynamically created, so the info of consumers
> depending on mei client devices is not present in the firmware
> tables.
>
> This causes problems with the probe ordering with respect to
> drivers for consumers of these MEI client devices. But on these
> camera sensor devices, the ACPI nodes describing the sensors all
> have a _DEP dependency on the matching MEI bus ACPI device, so
> adding IVSC MEI bus ACPI device to acpi_honor_dep_ids allows
> solving the probe-ordering problem by deferring the enumeration of
> ACPI-devices which have a _DEP dependency on an IVSC mei bus ACPI
> device.
>
> Add INTC10CF, the HID of IVSC MEI bus ACPI device on MTL platform,
> to acpi_honor_dep_ids.
>
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> ---
>  drivers/acpi/scan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index e6ed1ba91e5c..f32a2c738c8b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -798,6 +798,7 @@ static const char * const acpi_honor_dep_ids[] =3D {
>         "INTC1059", /* IVSC (TGL) driver must be loaded to allow i2c acce=
ss to camera sensors */
>         "INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c acce=
ss to camera sensors */
>         "INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c acce=
ss to camera sensors */
> +       "INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c acce=
ss to camera sensors */
>         NULL
>  };
>
> --

Applied as 6.9 material, thanks!


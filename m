Return-Path: <linux-acpi+bounces-3274-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9D84C6DC
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Feb 2024 10:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B789288C26
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Feb 2024 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8051320B09;
	Wed,  7 Feb 2024 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="moExf0LI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB287208BD
	for <linux-acpi@vger.kernel.org>; Wed,  7 Feb 2024 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296803; cv=none; b=mNVYwVRe1LXZJJbTZXiSJqLNKM/Q5Sq+Wz6cbnpuKt4ZDcXH608Y+e4HZdxwmTJIz9mvStwLi7mjoi+r1ojhdwX5LkYjPkOqd201hwcxPwPwxZsydcFAoPyRXAnq9di3O32nk6jzGv6lATcEq/T1uuGBG5gvKqvewkadiuNvaHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296803; c=relaxed/simple;
	bh=XtzAzhydXVojCJUDRGlPCkWB+IX4V/2fen8vjztCRuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAh+QTmmHqy/PU+rP53SutMtHhT8lLWPiB9DO+M2vFriDmU1BFzsjVjAI7RiR2g4fI8mCWPFCcdA128H2gnvtWoZh0fgHWC/mNeb39Y25YN2MKbItAshKpHA56LiOBAP/yg9mHtKyq00/3TUmTXvWfsjinaFWsbDb6yGtdoshwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=moExf0LI; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6043d9726adso3009717b3.0
        for <linux-acpi@vger.kernel.org>; Wed, 07 Feb 2024 01:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707296800; x=1707901600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8Bnbhq2BN3ojZOkegRmYEkU2qfCG+U1q5DiCoDQh3Y=;
        b=moExf0LIBmZe1ApvdqO21l+Z9+SUkWVQBRaCL4xPu/tsHXmNoGOmGfkEmFbwyRq79F
         fxf70EhkFUkdqr8eAR/H6N8ht/e1M/hKo7vI3Bwx+gMaCXgOt3FkSctxEZECdqH3T538
         LwgL/TqvwZHFkMSbqPKDWmlW66iElTfIrNizMAHqujhMy+sMKjrJrIo7Ljw+JAN0zLar
         gXMPRSgfr2JWZxpXJ1dQbk5E2VcTDXe4MgZbNhMhVdpsTuwHz7G6X6Vn8NNUpzob2/8m
         f6/e76ijusOtf145DL/JEIhAwyM4DvC6IvvHrW45fKYcI4hWtQa3G3Ujd7zhl9g6RhSv
         n8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707296800; x=1707901600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8Bnbhq2BN3ojZOkegRmYEkU2qfCG+U1q5DiCoDQh3Y=;
        b=chqEpCp4w3ueQj2exFs+mxn2jhF16l9qobkAnKPN4+XZ68sfTqys+Lb74CCJKzMENs
         afmX/tM2BwugheO9zuDP/r65owkpySz82XH6gbD2F5tQVTKqriljuhM+pA0zGicV3kAT
         RgfZ1A6tR5RfOf4jRGqCVKaXxKZeVWWO6jBOMRvRgbrMDdDkoD+ystpkYKg+tq7a1Mmb
         R5I/v51bDrq1KRIp4YnOB813W3gUOdjZhwvXFUOAAR1viNHp0AyCdkv/tBTiNrDdw0l3
         KjqZI5NYzZb3UzekCIhwXgHbniQEhcJ9IiJp6QtWogPMcRSILlZzymdQUfpFZZerW2/R
         v5yA==
X-Gm-Message-State: AOJu0YxndDOJCnsB6+KVYEyVNpX7Pnpylk0DwOdzFz03fIrpkzSfcIqc
	UjNAt93C6rGCIv+pzudsp7gCw7pwZnNqYJxNKdbErD72oRHVcTh2gqowBwET7BDhSbOgAx2SyQs
	pa5FQZmKozqeLS0m0XLvZCG78fQuVsQhimelIcw==
X-Google-Smtp-Source: AGHT+IE9kQLOyMxZJrvYYGKo1ECODIXWF6GAPZsufOzV6bMReAlZqvDfxeIfj7nYWsVDppndWtY53yV1cgOUEnw41oM=
X-Received: by 2002:a0d:cc95:0:b0:604:99b2:f371 with SMTP id
 o143-20020a0dcc95000000b0060499b2f371mr137897ywd.1.1707296799922; Wed, 07 Feb
 2024 01:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org>
In-Reply-To: <20240207084452.9597-1-drake@endlessos.org>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Feb 2024 17:06:04 +0800
Message-ID: <CAPpJ_eeV45QErAYRADUAHJUsGP0q5DqQJBQsgDdGZL0H0Q1isA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
To: Daniel Drake <drake@endlessos.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, mario.limonciello@amd.com, rafael@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Daniel Drake <drake@endlessos.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The Asus B1400 with original shipped firmware versions and VMD disabled
> cannot resume from suspend: the NVMe device becomes unresponsive and
> inaccessible.
>
> This is because the NVMe device and parent PCI bridge get put into D3cold
> during suspend, and this PCI bridge cannot be recovered from D3cold mode:
>
>   echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/unbind
>   echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/unbind
>   setpci -s 00:06.0 CAP_PM+4.b=3D03 # D3hot
>   acpidbg -b "execute \_SB.PC00.PEG0.PXP._OFF"
>   acpidbg -b "execute \_SB.PC00.PEG0.PXP._ON"
>   setpci -s 00:06.0 CAP_PM+4.b=3D0 # D0
>   echo "0000:00:06.0" > /sys/bus/pci/drivers/pcieport/bind
>   echo "0000:01:00.0" > /sys/bus/pci/drivers/nvme/bind
>   # NVMe probe fails here with -ENODEV
>
> This appears to be an untested D3cold transition by the vendor; Intel
> socwatch shows that Windows leaves the NVMe device and parent bridge in D=
0
> during suspend, even though these firmware versions have StorageD3Enable=
=3D1.
>
> Experimenting with the DSDT, the _OFF method calls DL23() which sets a L2=
3E
> bit at offset 0xe2 into the PCI configuration space for this root port.
> This is the specific write that the _ON routine is unable to recover from=
.
> This register is not documented in the public chipset datasheet.
>
> Disallow D3cold on the PCI bridge to enable successful suspend/resume.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215742
> Signed-off-by: Daniel Drake <drake@endlessos.org>

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>

> ---
>  arch/x86/pci/fixup.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> v2:
> Match only specific BIOS versions where this quirk is required.
> Add subsequent patch to this series to revert the original S3 workaround
> now that s2idle is usable again.
>
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index f347c20247d30..6b0b341178e4f 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -907,6 +907,51 @@ static void chromeos_fixup_apl_pci_l1ss_capability(s=
truct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_save_apl_p=
ci_l1ss_capability);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL, 0x5ad6, chromeos_fixup_apl=
_pci_l1ss_capability);
>
> +/*
> + * Disable D3cold on Asus B1400 PCIe bridge at 00:06.0.
> + *
> + * On this platform with VMD off, the NVMe's parent PCI bridge cannot
> + * successfully power back on from D3cold, resulting in unresponsive NVM=
e on
> + * resume. This appears to be an untested transition by the vendor: Wind=
ows
> + * leaves the NVMe and parent bridge in D0 during suspend.
> + * This is only needed on BIOS versions before 308; the newer versions f=
lip
> + * StorageD3Enable from 1 to 0.
> + */
> +static const struct dmi_system_id asus_nvme_broken_d3cold_table[] =3D {
> +       {
> +               .matches =3D {
> +                               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUT=
ER INC."),
> +                               DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.30=
4"),
> +               },
> +       },
> +       {
> +               .matches =3D {
> +                               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUT=
ER INC."),
> +                               DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.30=
5"),
> +               },
> +       },
> +       {
> +               .matches =3D {
> +                               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUT=
ER INC."),
> +                               DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.30=
6"),
> +               },
> +       },
> +       {
> +               .matches =3D {
> +                               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUT=
ER INC."),
> +                               DMI_MATCH(DMI_BIOS_VERSION, "B1400CEAE.30=
7"),
> +               },
> +       },
> +       {}
> +};
> +
> +static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
> +{
> +       if (dmi_check_system(asus_nvme_broken_d3cold_table) > 0)
> +               pci_d3cold_disable(pdev);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d=
3cold);
> +
>  #ifdef CONFIG_SUSPEND
>  /*
>   * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3col=
d, but
> --
> 2.43.0
>


Return-Path: <linux-acpi+bounces-19347-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E034C91165
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 09:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B8EB34F1AF
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190A92DEA74;
	Fri, 28 Nov 2025 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1JHDnhM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1bNKZ/A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613AB2D5C8E
	for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317152; cv=none; b=JG/MH+GsnbE0j5GoRZ1KI+5xsdi7StNFKBAqxqBOEuoNPe9izYx27cjlf977saWFX6R1bgkV+gWYdxoVRcTZVD9xWB9eJhGsWlozdXj11NjUi7/l7NkKAru5e3fVFOCuLRmOj7MKsY86QdAMWi5YWoqJQTPs+9nvtaTYBx1h9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317152; c=relaxed/simple;
	bh=FPIIUOyTg8pGSe3VMid6kL7fnIsGm87S00jz238lCJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBThIAWzG126IJ7Qej+ECD72B3O662mnhtHLLJ8hJrRBwEwPj7n98GuKtR33Pg5C1k8zzsHMDsg9X9ykX0R0E2qtsx+xnQMdF3iEG1Pxa+03BDVksmn7z0T3qhR++VSwnqp91as1UMLYa550eTo529mID9WOknfeQhQN9lbELQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1JHDnhM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1bNKZ/A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764317149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3QLe2XaO0RWFOq1Znr3L5adsNAtxbfgecqm9jeMni8=;
	b=d1JHDnhMITJfvVsGZB3QVJpvOBrDFh0mnJJAQ/HvZI4X7WQ83fcTbk9Z00kgFCphvwy9tm
	6f/anbuWNNx6Y0MgmHVVuf6a4d1JbUt6w2bKT3X8Czs8c1iExIGDfp2pWBWlyTzUsS1jCv
	IY4AEbio7nRZNSII7jteE6tbRss7YDM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-YbYBX1bHO1-zeTzhUl3M3w-1; Fri, 28 Nov 2025 03:05:47 -0500
X-MC-Unique: YbYBX1bHO1-zeTzhUl3M3w-1
X-Mimecast-MFC-AGG-ID: YbYBX1bHO1-zeTzhUl3M3w_1764317146
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b73599315adso118847666b.2
        for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 00:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764317145; x=1764921945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3QLe2XaO0RWFOq1Znr3L5adsNAtxbfgecqm9jeMni8=;
        b=K1bNKZ/Ao9+QE31w58bIp8SQ2OxcmwKpviElX2XajKKer2RPC1T3XUFIsbN6wbi2T+
         ThVYy7PMQT5wk8U7fLX8qvwYo0kmizGUAofmqSQU9jKKYGSUwVq5qome6eO5HoHlcq6P
         nv929JrpRdOExGpd4HiyzxLPwYfaL4SBNpERIJ25UM8Dedai5J+RBAPUNnBcFSYgZUyQ
         pfpHtgVKRyGSFrIwIqJIhhBGFVjuNXLcwHPkA+5t7inFASKzZh4G69owGRvB/NbIheNX
         xrPR2F8zi/snfIbxhACe6WcvGOO1sb7irpupLqINuwV7ct6fX7DE4E/+YQ61O60uE8vb
         1U3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317145; x=1764921945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p3QLe2XaO0RWFOq1Znr3L5adsNAtxbfgecqm9jeMni8=;
        b=HXc9jT0tnyLEsMu7Yf2VYTdjhmvqHlZGRZpilxNz7PNfVVlVrUEDAsFlFQC/sAw4GV
         hsKhzNVKKclLjF2+zIcskYp24pOC8LRrz+ggSsoLiJ/v9b7u83pnNPAwhCqy6dJl8qns
         WL+n4qDP7zGpFCyvgvuPU59R5WMSg3MqJT2zJwp4KZHNw87NzJsyu4jr8AVApC4/hFJy
         tRSqkkOST3Wgn237w0gyFoQCtRRNefxWh9S658lQzh5GBgI1zyy02yyKRJR1ca5zLbo6
         /BDDp9I/QqprJTC1hg0AJDqKq47FOtKzLgBKKzhlCg+ryMttdXSwNljHhSFLd6cvHwA2
         PIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK7mCmXjofBjESMCm30kyGGXC34rPdpTMTHq5qowYbg8IdNXa3GMXDU8HVufKY7NPjDrrsolMIjaV3@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNPqdJDFILtDZIFTMEJjk1jjwlRPywbmewFGIwbgwzsHJliCy
	LxEuFSU0ysvLnOcPzBj4MHl0nYKEziEJBQs7K4YoTz1tsuMCxQtBRRppFvS0NhdF2Zd6q4lVxUy
	MEYhF5aF7e+rmQm29AzQ7jgvvPKTIxObT+X4+Xjadjim1kRiXfWJRB3ABEsbM2NGe40IJuF0xpt
	+bE5vYbtMYseItxfcahfhg/VgRSsVEH5Uk3RwuXOhk01vKTOdm
X-Gm-Gg: ASbGncug2HPpUUjO6FHLoF8uLHfloKFlHuO7RFt2Rm/hxQfjtCCIGz8H/Mcaupk/hKB
	ENblJaGy9obj5IYSEk5Smki6NlFciGFByNEJJ0RoQZfSnsott9/vwhREKPq+XE4k3HhKhDugnka
	r692oOPOUCNcIZBxW6u7DaBa/ElSG+sB6teI1turGMUnXeYEtrqjqY9PoKv+C+dEfbZTgsqV8wL
	u4g
X-Received: by 2002:a17:907:970d:b0:b73:8cea:62b3 with SMTP id a640c23a62f3a-b76c555d4e4mr1585063266b.41.1764317145501;
        Fri, 28 Nov 2025 00:05:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKK0ygpmbqqehPl2TIRSD7djKwvPkm+PmaYUeeZWjX873/DUZ190EeXFzXWzQKSZKNDymJ9vPo1YTZbY7aFJ0=
X-Received: by 2002:a17:907:970d:b0:b73:8cea:62b3 with SMTP id
 a640c23a62f3a-b76c555d4e4mr1585059566b.41.1764317145083; Fri, 28 Nov 2025
 00:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMBhvbYA=onQkkcgkODaTj=+tkybwo28Cdi6P3vodGpVZi8OVA@mail.gmail.com>
In-Reply-To: <CAMBhvbYA=onQkkcgkODaTj=+tkybwo28Cdi6P3vodGpVZi8OVA@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 28 Nov 2025 09:05:33 +0100
X-Gm-Features: AWmQ_bkLgWKix4gnWAJoUAVbND5jxAoYl0f5o50yL4aev8Kz282JnEE0s8Yv9uc
Message-ID: <CAO-hwJJRisVpZWeSA+3_fLaa8_52f7ypUocDcD+PojuF3KjHYw@mail.gmail.com>
Subject: Re: Regression: SYNA3602 I2C touchpad broken in Linux 6.17.7 (works
 in 6.17.6 and previous versions)
To: Vijay <vijayg0127@gmail.com>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, jikos@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 28, 2025 at 7:40=E2=80=AFAM Vijay <vijayg0127@gmail.com> wrote:
>
> Hello,
>
> I would like to report a regression in the Linux kernel affecting I2C-HID
> touchpads that run through the Intel ISH + DesignWare I2C controller.
>
> Hardware:
> - Laptop: Infinix Y4 Max
> - CPU: Intel (13th gen core i5)
> - Touchpad: SYNA3602:00 093A:35ED (I2C HID)
> - Bus path: SYNA3602 =E2=86=92 i2c_designware =E2=86=92 Intel ISH =E2=86=
=92 HID
> - OS: Linux (Arch/CachyOS)
> - Kernel config: Default distro config
>
> Regression summary:
> - Touchpad works perfectly in Linux 6.17.6 and below versions
> - Touchpad stops working in Linux 6.17.7 and all newer versions (6.17.8, =
6.17.9, etc.)
> - Desktop environment does not matter (Hyprland/GNOME both fail)
> - The failure happens before userspace loads
> - Touchpad also works fine in Linux 6.12 LTS
>
> This is a kernel-level regression introduced between:
>     Good: Linux 6.17.6
>     Bad:  Linux 6.17.7
>
> **Dmesg logs from broken kernel (6.17.7 and newer):**
>
>     i2c-SYNA3602:00: can't add hid device: -110
>     hid_sensor_hub: reading report descriptor failed
>     intel-hid INTC1078:00: failed to enable HID power button

Looks like i2c-hid can't even communicate with any I2C device, so this
is slightly worrying.

>
> And the DesignWare I2C controller logs around the failure:
>     i2c_designware 0000:00:15.0: controller timed out
>     i2c_designware 0000:00:15.0: lost arbitration
>     i2c_designware 0000:00:15.0: transfer aborted (status =3D -110)
>
> These errors appear only on 6.17.7+ and not on 6.17.6.
>
> On working versions (6.17.6 and 6.12 LTS), the touchpad initializes norma=
lly:
>
>     input: SYNA3602:00 093A:35ED Touchpad as /devices/.../input/inputX
>     hid-multitouch: I2C HID v1.00 device initialized
>     i2c_designware 0000:00:15.0: controller operating normally
>
> This narrow regression window should make it possible to identify the off=
ending
> change in either:
> - HID core
> - I2C-HID
> - Intel ISH HID
> - DesignWare I2C controller
> - ACPI timing changes
>
> I can provide:
> - Full dmesg (working and broken)
> - acpidump

Are you running on a full vanilla kernel?

The changelog between 6.17.6 and 6.17.7 is rather small, so it should
be easy enough to bisect and get the offending commit.

I have my suspicions on:
f1971d5ba2ef ("genirq/manage: Add buslock back in to enable_irq()")
b990b4c6ea6b ("genirq/manage: Add buslock back in to __disable_irq_nosync()=
")
3c97437239df ("genirq/chip: Add buslock back in to irq_set_handler()")

Because anything else is unrelated to any component involved in i2c-hid.
(But that's also assuming you are running vanilla kernels without any
extra patches.)

OTOH, I've booted a 6.17.8 and 6.17.7 shipped by Fedora and I don't
see any issues related to i2c-hid, so those 3 commits might not be the
culprits.


>
> Please let me know what additional data is needed.

Can you do a bisect between v6.17.7 and v6.17.6?

Cheers,
Benjamin

>
> Thank you,
> Vijay.



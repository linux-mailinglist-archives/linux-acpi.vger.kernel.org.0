Return-Path: <linux-acpi+bounces-17666-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF00FBC8BEB
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 13:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DD844F8EEF
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 11:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27AA2E041A;
	Thu,  9 Oct 2025 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNoiJ37l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E20221FDA
	for <linux-acpi@vger.kernel.org>; Thu,  9 Oct 2025 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008782; cv=none; b=SHzxf32YIdP05+U1svgyM3YsCjJs8KJ8S1h5BeNdrwWXQZamQXlrtFCEVDFAmy8yezW2OAyK2HEmH4kV/k2IP3XPNC3s8O8x6AKGPDlxTOuPDUnPKVrmGtculeKzQXnSkU04vTiL3IaL5Fe+CRdW0PQqAGB42LMUrOLK5eYIJ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008782; c=relaxed/simple;
	bh=mzeWOdj3lBj+Ke0QviDFWI2aF1kcLsskxWN0A79AnHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dt+v0fp7UjlosFA26+VcZoX8VEn2AabsA1OteRt+OCkrR5fQT99//rydRsVi5LcvEV7TDjr1lCUDpkWCaslgmof8ODYPTNTsk6DgCQywxIs0Zv/+ffZTo+UoAy3EWQjf23/k0l87h4sMPdlIq3RzLN/nJhwrwEic93SLeLJ/8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNoiJ37l; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d60501806so8533307b3.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Oct 2025 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760008779; x=1760613579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzeWOdj3lBj+Ke0QviDFWI2aF1kcLsskxWN0A79AnHU=;
        b=jNoiJ37lCUQ9Hrm2hMpur0n3OpmXylsTAvQFzFo0gEHLdPW1H7xLOEfZx9IMP3xJGG
         VvaFojxgSsr0dFIBvT0p9gx6C2qVKiKNUQeCfRio9yhV6GZjq9rpyyrteqxqW9Ew3dBm
         wtvaqMjirKwpcBo4MgJpiCLn7sWEkQpEyqFiwGTjc5zHrlT4QCRizWiXWVk6zMf3FYYn
         bzUTIQSKLADIffCIHWelPhf43EqQYtzVSfMGzuGbrzIwj9QJsP6FN+oluyC+bzTKhDgF
         5nZ3Uo6yeEy5h0e9DLaazODqWGp9Q080LEkzOtn2P2FcQKQiw+6Kon0LQ4PFBZDDcg2+
         Grtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760008779; x=1760613579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzeWOdj3lBj+Ke0QviDFWI2aF1kcLsskxWN0A79AnHU=;
        b=NBeblpfHOOWoqE6dDb4gJOiKviZtBxnpQqUsRuVBvXlNdj3PAjbawPgQamGjJknXoQ
         R+nJ0jqFemhF/DhanoCv8d/KAuoEsvqxOHvDUQdV5x97h/e9jRbf3hkbwHIuHg9UfdTK
         SP7pYZ8ol0aocotHiytrJXi48cJbqIRUpl+obthO0hEe5jq99/xp3PIb5sAcC9Itq4sQ
         XqNwS8RoXr73MTnWeR9VR4TWjw25FdZ+h0+R8A8JoHjcvA8taAuVL7o7dCjyoEfL7GmI
         3TOxSNQx4uKLf7OFwVIukrK7bVLX0cGcBlq8ISq+m81MT4PAvMF0bTm4QSGW6dF83P3R
         3GCA==
X-Forwarded-Encrypted: i=1; AJvYcCWRDMtVXENaCdLSD2MwedE8xUgjHyjegxAI6Z6W8hrMINzSsNeB74cGPM68eUR1SQUU9mDAsR1xHmXa@vger.kernel.org
X-Gm-Message-State: AOJu0YytpwfEY3B2dCClH+1jgcWPObKapq+JdE8ssP6xuSS0gqdPS3fI
	dK6APfdaYj6T8o2j7v5CJnhgOY4MfJ/Pdo7/YBS3lja6R9xzjIeR274cjGWW6dUZ4iS7eGOYXo0
	igQhtfe1VBWr3xRt7swix6+V42tpgNkE=
X-Gm-Gg: ASbGncuiL0okaC8N10zUxy1IFBVge8usUsjA+x+6IcEmL4eySrntisFMCieV4zpWh19
	s6qy8qtFaCD4ogrIIFeVetTuJCNBZ1SL8kp/JXTuie5C7EV5vCY6kOJnp9qKlhB6UWy2DgrYsDb
	GjW1zJ2OdUVi20YaU64tSh4LzDGp3BlFvreIVneJiaxsSby23pLpB6pvy8OTggcd9hkh558WNJK
	pWoLnu4aS7V/H1hTYJo7SLckfEe63A=
X-Google-Smtp-Source: AGHT+IE5U7JyGi1AmeLjDi25hUOta+sU2hpJbVTN9Ai63ARDyOdLqRjdCN3h5Wr4u+tqZlHZJ+/pg/7Xr5jCWFq4BIc=
X-Received: by 2002:a53:d048:0:10b0:63b:8e80:c017 with SMTP id
 956f58d0204a3-63ccb672a0emr6807745d50.0.1760008779377; Thu, 09 Oct 2025
 04:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250913003842.41944-29-safinaskar@gmail.com>
 <20250913054837.GAaMUFtd4YlaPqL2Ov@fat_crate.local> <20250913055851.GBaMUIGyF8VhpUsOZg@fat_crate.local>
In-Reply-To: <20250913055851.GBaMUIGyF8VhpUsOZg@fat_crate.local>
From: Askar Safin <safinaskar@gmail.com>
Date: Thu, 9 Oct 2025 14:19:03 +0300
X-Gm-Features: AS18NWAGN6ExXhEWeXK-ERFvGpf6JdjWShiWpIPYOnPjMCR9bXVHwIY8E_1WxIc
Message-ID: <CAPnZJGBwFqNAybORpTtRfjtGwMQiBtd+rATD=mh8ZgE3owT_ow@mail.gmail.com>
Subject: Re: [PATCH RESEND 28/62] init: alpha, arc, arm, arm64, csky, m68k,
 microblaze, mips, nios2, openrisc, parisc, powerpc, s390, sh, sparc, um, x86,
 xtensa: rename initrd_{start,end} to virt_external_initramfs_{start,end}
To: Borislav Petkov <bp@alien8.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 9:00=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
> Ooh, now I see it - you have virtual and physical initramfs address thing=
s. We
> usually call those "va" and "pa". So
>
> initramfs_{va,pa}_{start,end}

Okay, I will call external_initramfs_{va,pa}_{start,end}
(after I will remove initrd, which will happen after a year)

"external" means "bootloader-supplied" as opposed to builtin initramfs.

--=20
Askar Safin


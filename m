Return-Path: <linux-acpi+bounces-16977-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6B4B58B6D
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 03:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8EC4E14FC
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC71224240;
	Tue, 16 Sep 2025 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVxENWaX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF62E1F5820
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987336; cv=none; b=sSlmkwqb0TRrKWRiokuT3nck9W8aZyRQ1WkNu4PWjD7SxG76ZhA87p0JFoqAT4Ah6II1lp3WI+9LL6XyN0OzzAQnKtA2Iay8OLHhqzZH/GN2+l+Gz9xD5x9u0wdfFTbGDfo5msXt6vkoDMfCxMonuWdwtt5cYHb5ET912QlKslk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987336; c=relaxed/simple;
	bh=ixp1vRoqVO/aQuZyYy6zFP7jfZFHYTqyHd5Z6tSU/S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m14N49hdnnf9VeUiboth/+IPUEMoqTRxBTIEioSTaJ4oT29+bo0CvbsS7urUr2AekAjLmSUtKMXc6McPMiIstg/ASZ0o+dnlDy6trIGeZ9xuCTVW01Cbg6fShTnSbiuvHm5z/Jp6wga1XqDZLsp4AWtMYE839XtVJdCRjS2WonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVxENWaX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757987332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM/63QbNRNL2CWSzKhJPtVEvJogEqqs3VcsifJT7nZg=;
	b=DVxENWaXoju90hK0B9zzrXDH9c8/caskohxDsbR0Mtk8+kMSJKp646j6z5sVM87m4zyDXr
	POnWG+BJmAlABry/6/GYZ9tajme0sNQA9pzQOf7AP7nveOqHmENmqzVJINneohiV/Z1S1/
	UdnyS6GQ2sj8PeVMRyjvanZQsempc/I=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-3JUhAgxCOpW1xH2GB3BkPQ-1; Mon, 15 Sep 2025 21:48:51 -0400
X-MC-Unique: 3JUhAgxCOpW1xH2GB3BkPQ-1
X-Mimecast-MFC-AGG-ID: 3JUhAgxCOpW1xH2GB3BkPQ_1757987330
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-571c4a20e8aso1867396e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 18:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757987330; x=1758592130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UM/63QbNRNL2CWSzKhJPtVEvJogEqqs3VcsifJT7nZg=;
        b=ccyok70WDcOpAI1OU7FB9lnqppISGW/9a5oNW54Kyd+yjYk1G1orIeR0nlAbYHeBlo
         D45kvdJuvSjkP2i2UPEw1Vx+ayzDeLZadGF6vGglXabeldr3nyksrk9kJ46J37QcCuRc
         6aRRiTuD4mOj2xk0ELJ56u9WzOt7Qj3KUE8vuHO61Fb6TbG7fPGomkyqiIRkmG0qDVw2
         SWx7eSh3rDlVtX/SV9RAmroyAwLpTASMKNXIiIJtkRC9bQwGCvnk6U5a4qPCVcxybDuM
         JQww6N+874UuOl8L5szZPogUm7mnISQwE23/xvfcWhIMO2/Xf+BI+LEKASSc5kQ5NdVV
         c7zg==
X-Forwarded-Encrypted: i=1; AJvYcCXnUJpErVCOAVDo437MImtKNLAva93GATdn7fF1vU96M1+fgBWoHlvmUewH7ecskrRMUWP0hrJpi2l0@vger.kernel.org
X-Gm-Message-State: AOJu0YzaiC5L8RKjyhtuMZxbDdMol4FeP2q6xwPsp4o4FCEKqmbK5oUB
	cVEpVk0iisixfRyvY9M9VD7GM/wmeggxCm/4qW+IwAcim60tdU+wk0c/eO6jrRgnT5MihDvPPWP
	VvFZiMOBdnj/NQKq6wblkVunzA7ofCITVDrSjvxB+QlxMd/7QIE1daAjT6X4CVdK5Dg58GRz1zv
	4be9g5zoNaoR9vgx1tRxRAWCitr/wA12wcXbYVGQ==
X-Gm-Gg: ASbGncuD7RZFEVN53yV/UQfYU4jKRjZKX3yKIlZ5pSJnHRh4rFJYf2NbGN3d2gLbjeO
	DiOwniO4CjIvmsT1h4aqcokfUqBIju1tegkS8uiQUWPQZ2vf4wN/GXmQoH00oGKuZfKqbFKQapi
	w3IzLXOiLk1i5Le0JPjJfAiA==
X-Received: by 2002:a05:6512:3f21:b0:563:d896:2d14 with SMTP id 2adb3069b0e04-5704f7a3535mr4252950e87.36.1757987330046;
        Mon, 15 Sep 2025 18:48:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi0qyrJSXhatUAjAN5GaSbgChEfkulnz/zBRoEI09ayrVbCpTRhDlFRFU2ScIQdlOHU/dANXpgiKsiuT/Fm5k=
X-Received: by 2002:a05:6512:3f21:b0:563:d896:2d14 with SMTP id
 2adb3069b0e04-5704f7a3535mr4252904e87.36.1757987329545; Mon, 15 Sep 2025
 18:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912223937.3735076-1-safinaskar@zohomail.com>
In-Reply-To: <20250912223937.3735076-1-safinaskar@zohomail.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 16 Sep 2025 09:48:40 +0800
X-Gm-Features: AS18NWBkCHbtMZDfiuZiXnfW8KzozFHrUJlGejiASEzNumvZVB8NmHoE7UrrQwg
Message-ID: <CALu+AoRt5wEgx-=S263CReDf8FmLWwjs8dF9cX4_jFcMUkuujQ@mail.gmail.com>
Subject: Re: [PATCH 00/62] initrd: remove classic initrd support
To: Askar Safin <safinaskar@zohomail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
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

Hi,

On Sat, 13 Sept 2025 at 06:42, Askar Safin <safinaskar@zohomail.com> wrote:
>
> Intro
> ====
> This patchset removes classic initrd (initial RAM disk) support,
> which was deprecated in 2020.
> Initramfs still stays, and RAM disk itself (brd) still stays, too.

There is one initrd use case in my mind, it can be extended to co-work
with overlayfs as a kernel built-in solution for initrd(compressed fs
image)+overlayfs.   Currently we can use compressed fs images
(squashfs or erofs) within initramfs,  and kernel loop mount together
with overlayfs, this works fine but extra pre-mount phase is needed.

Thanks
Dave



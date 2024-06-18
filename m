Return-Path: <linux-acpi+bounces-6501-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F3290DC5B
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 21:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4569F1C219D1
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F435166306;
	Tue, 18 Jun 2024 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="bQbk0rhJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36F1662F6
	for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2024 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738747; cv=none; b=pFX+oR8vZRZS9dRShcSvNLMm46YHBmpXNFAYRtDKJTOsAwIXM9Y0brSGcfgf9ue1QRicRGxsFKTTJ51WE8zwRl7McIQqjaIT3RT9Q9wnEmeKN6Wuq0HTh8bA8xTi47xIQ0zkEqRLw823haLoFJIkAwu2aCz1x0CxHaA3h9TQnxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738747; c=relaxed/simple;
	bh=z2AFd9pz/jXk/YAc5SISacv07MSOWo0blu7vJvfpBUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoWMGln54KTLGGj5skJXB7fLY+u7o8u4zr8RNBTN7/+6ZP91yprMnDG+Av2lVimhykPW15s5fQpo8HmsKaOJ8iYYGm2BDGBN0tT3IRIfgcoBaPY8EjH38LAg7YP2spKidL1h4rp6LjG+F0WTBfcwO+a5Paj2SckOk3KhZAZFtE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=bQbk0rhJ; arc=none smtp.client-ip=209.85.166.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f193.google.com with SMTP id e9e14a558f8ab-375932c953aso26405725ab.0
        for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2024 12:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718738744; x=1719343544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AmK+WCzRtQqOjkKB2JoI/nzEulWCZnGrnBCxb5hHO0Y=;
        b=bQbk0rhJR3XfusQGmaVR/P5jR/BJhrw7x3P9+rdQlcCn5NZm643X0EglX7XrbI/VF/
         HVv/2Rw6umiVhwEgbSnOthZpkwBVOLJyQLWwd1PGakHu+KRwu+fGmJtc27Ug4l+oe4C4
         B7FqfYsfg2E2wzaic4mI/nFKhX9TTIdYxxFtjFat6Y7xi/OoE448Xqg4rJNcPKTMekZb
         JjIaUYWYscFwuDk91FTwGC7oHvaAJ7bC/msYdCvWRCvmtT9CnRNeYCx4R6hex5IF2Vtj
         UzM27gUOOnzdt3spP3TZMBnWTVfJbc9Dtc99JREvHcN+cPX7ISQFd0pMrwq954xmXNF9
         gdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718738744; x=1719343544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmK+WCzRtQqOjkKB2JoI/nzEulWCZnGrnBCxb5hHO0Y=;
        b=dDSGkuIsC+OloAUOA1SQG2DIstwYKct4D5Q2RBtEHhKk3PaPpCNfOZhcqIDUkqdbC7
         Dj7u/a0P9XktYCcEwtvR0uc89WSMc/7fmBC6drEmT5evOA25zJA+UD8C0NWZD8Hapg+U
         SaXNMQpyHhMtz+Dx9Infipcsvr7xNrTRizwx+TON7nFYB0DJ3GMhz56z35KMQ7107qrb
         tE6O8qsit9VYWixM++U1LwRPuK4k3Dt6EQhC53EgbCpJ6oDbkO7Tcv4MG5ecVnAJFwTq
         DkGlBsIpNzbiiadWW6vA70nhHN9g6McjuIQ0vFSdbtUAlq+d/puRp3PH3OwS0XwEhrmk
         6HBg==
X-Gm-Message-State: AOJu0YxRd+10lkCHYX343PRupQT1lwvS94vu6EHysFFe6awWxJlyMpzv
	OdWfo/lfwW1+WHOj486sPf/Bqao/I+pjapy/+ipecHz0PwqfiBftrjC1dOwUQzg=
X-Google-Smtp-Source: AGHT+IGw+9KohnfLPrcSNmKX0uGzcp+zBSGth4mvsmBMnMKrkEA/97uLyyo5AazW40dOWlzHo7LoYA==
X-Received: by 2002:a05:6e02:160b:b0:375:c296:bf90 with SMTP id e9e14a558f8ab-3761d63d71cmr8136105ab.7.1718738744559;
        Tue, 18 Jun 2024 12:25:44 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:b5f:d6ad:8a73:5578])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375d86bfa6dsm22384015ab.50.2024.06.18.12.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:25:44 -0700 (PDT)
Date: Tue, 18 Jun 2024 14:25:41 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	linux-kernel@vger.kernel.org, mmikowski@kfocus.org,
	Perry.Yuan@amd.com
Subject: Re: [PATCH] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnHfNbLTgY1op3Zv@kf-XE>
References: <ZnD22b3Br1ng7alf@kf-XE>
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnHSKiaYf2tIQo58@kf-XE>
 <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com>
 <ZnHXfLEwk2uRbg58@kf-XE>
 <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com>

On Tue, Jun 18, 2024 at 01:58:07PM -0500, Mario Limonciello wrote:
> On 6/18/2024 13:52, Aaron Rainbolt wrote:
> > On Tue, Jun 18, 2024 at 01:35:57PM -0500, Mario Limonciello wrote:
> > > On 6/18/2024 13:30, Aaron Rainbolt wrote:
> > > > On Tue, Jun 18, 2024 at 12:09:19PM -0500, Mario Limonciello wrote:
> > > > > On 6/17/2024 21:54, Aaron Rainbolt wrote:
> > > > > > acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> > > > > > 
> > > > > > The _OSC is supposed to contain a bit indicating whether the hardware
> > > > > > supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> > > > > > be considered absent. This results in severe single-core performance
> > > > > > issues with the EEVDF scheduler.
> > > > > > 
> > > > > > To work around this, provide a new kernel parameter,
> > > > > > "processor.ignore_osc_cppc_bit", which may be used to ignore the _OSC
> > > > > > CPPC v2 bit and act as if the bit was enabled. This allows CPPC to be
> > > > > > properly detected even if not "enabled" by _OSC, allowing users with
> > > > > > problematic hardware to obtain decent single-core performance.
> > > > > > 
> > > > > > Tested-by: Michael Mikowski <mmikowski@kfocus.org>
> > > > > > Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>
> > > > > 
> > > > > This sounds like a platform bug and if we do accept a patch like this I
> > > > > think we need a lot more documentation about the situation.
> > > > 
> > > > It is a platform bug, yes. See my previous email,
> > > > https://lore.kernel.org/linux-acpi/d01b0a1f-bd33-47fe-ab41-43843d8a374f@kfocus.org/T/#u
> > > > (I meant to send this email as a reply to that one, but failed to do so.)
> > > > 
> > > > > Can you please share more information about your hardware:
> > > > > 1) Manufacturer?
> > > > 
> > > > Carbon Systems, models Iridium 14 and Iridium 16.
> > > > 
> > > > > 2) CPU?
> > > > 
> > > > Intel Core i5-13500H.
> > > > 
> > > > > 3) Manufacturer firmware version?
> > > > 
> > > > The systems use an AMI BIOS with version N.1.10CAR01 according to
> > > > dmidecode. This is the latest BIOS available from the manufacturer.
> > > > 
> > > > > 4) If it's AMD what's the AGESA version?
> > > > 
> > > > Both affected systems are Intel-based and use heterogenous cores, not AMD.
> > > > 
> > > > > And most importantly do you have the latest system firmware version from
> > > > > your manufacturer?  If not; please upgrade that first.
> > > > 
> > > > We are using the latest firmware. (We're trying to work with the ODM to
> > > > potentially get a firmware update, but since this affects more than just
> > > > us and a firmware update may not be possible for everyone, this would
> > > > likely be worth providing a kernel-level workaround for.)
> > > > 
> > > > I can easily provide more detailed information - would the full output of
> > > > 'dmidecode' and 'acpidump' be useful?
> > > 
> > > Does your BIOS offer any options for these?
> > > 
> > > Intel(R) SpeedStep(TM)
> > > Intel Speed Shift Technology(TM)
> > > 
> > > I believe you need those enabled for this to work properly.
> > 
> > Neither option is available in the BIOS settings UI, however our ODM
> > confirmed that both Intel Speed Shift Technology and Intel Turbo Boost Max
> > Technology 3.0 are enabled by default. They did not mention SpeedStep,
> > but I assume SpeedStep is working since frequency scaling in general
> > works and the kernel patch fixes the issue.
> 
> Got it.  If those are enabled I think it would be good to get comments from
> Rafael and Srinivas about your specific situation then.
> 
> But regarding the patch, if they are agreeable to this "kind" of knob for
> debugging I personally think it's better to have cpc_supported_by_cpu() look
> at the kernel command line than plumb arguments from the module down through
> every function.

Just to be clear since I'm not all too familiar with how kernel params work,
should core_param be used here? Or is there a variable that allows
accessing the entire command line to look through it? I don't think I can
use module_param in 'arch/x86/kernel/acpi/cppc.c', core_param has a
comment over it describing it as "historical" so I don't think I should
use it, and early_param looks like something one is only supposed to use
in code that runs very early at kernel startup. I can probably figure it
out on my own, but a quick pointer would be helpful.


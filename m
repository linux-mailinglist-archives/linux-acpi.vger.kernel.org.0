Return-Path: <linux-acpi+bounces-6496-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5644190DB92
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 20:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E38C1C22516
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45E615ECCD;
	Tue, 18 Jun 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="izFFSTog"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1A15E5D2
	for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735409; cv=none; b=DjC2loXvpeUOKNrgkqBk5oYSLEBhlK7XfII3rceaD9oVCuNkSOeDjaQhzyGEvX+cC6omfZBsV6u8wV4NjT0qE3yHFdlEG+4TzEF+mO4+ET4YxWa30NWmiK+12VC2uK176LxudDhyVuStovu1PryZhSAHl3CTbUf+dfh2YXkud/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735409; c=relaxed/simple;
	bh=RbUj7YnGoY0hmCjZnaaNuFTp3lL/ckTgWn8Mt2zGzno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzmW4bQZr816+cSPLg2Y0CTb5x5GG4wXFXU8i6rMZMGJ7TsU1p/9oKF1UyhIGLHZ51NY9fhs7EU9ZSzXNrNgMwO8yAi+urCeo7S83PzTlhDSj8nrhsc7IAPOe1FAQsZLBk9w7UwUhVa1ErR6T/SGTGTdsgF5u8RUKMPZQdxh4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=izFFSTog; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-7eee5740aceso92946839f.3
        for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2024 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718735406; x=1719340206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zyO8jjK5Vx3n7QlCTiUf7qwKHCXenr2vDYIC8Apx6M0=;
        b=izFFSTogk96UTpglToo32FbB463T7mVKJ/B3NcPqsx29Owb4DQwgmtnsqCAiYUp6gB
         MyVXUK9pvM8K/dNd3jwwymF/Nthi4y8B9BjfcQrM6gGv1aDiRGf8QeFGd/GAig7mLPSI
         tPKHR0fPiicuI5effGZ0VbXDBADdoWr5eEYRilbF1afBPviI+nQvIWlZ4QqfCbtHAAdr
         fUjcTNY3DwIhpi47oRitCKUGq3SzY7LY+55SHQNtvux6qpyfZRwHK611dkNWVHhmfzEc
         W9KSb0qqOEpc41hb03hGR8lFCaJV4tFL7HQS5xjDzCmPmvK0iLSSzG172MtB0Qum0E3p
         Y8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718735406; x=1719340206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyO8jjK5Vx3n7QlCTiUf7qwKHCXenr2vDYIC8Apx6M0=;
        b=EwbD7g5OKhnadEkcbiC0GtbJ9Ll/ytjk5TJ7M/IztwDPgH62meo25yaPpJAHZqYX6m
         xS3gml4UtxZPPHcvJm0PfZXj91CKZ5tni0EbLKxW7A4IzgDKJsYywWI04Ty38Y8+al9e
         eIgQrLY41Xq0Luk8TKQar5x0HgTiDpkC4Q4CKLJUOFqBLYmVWP/XsRbaIUZMXmq1BZoD
         IVcbIMbPvLBejaM78kCNDJis+ksuSrNN04pqYYXN9WkZIAQN58pDFi9dXcyjO2a15EAC
         CM0PE5Ztzp+OsXtnRy1nYdlE6TRUDnL/PTC07Z2YdG+ClNw66FrynUj4zldgw/Wd3VGT
         gQGw==
X-Gm-Message-State: AOJu0Yx5SErLKpZK9wXfIiWKjT0WrA2F4ZtzImh4o2osxvzsB241n+u0
	MokPLhB+qL6cFryZzsCClvPGyX//x2xGJly3VFK83x95mNFDP3VD5ZMGC93ZwuE=
X-Google-Smtp-Source: AGHT+IF0icxSe74O6RCAPKxXCwaSwIU0zUDrbZT+AVM1VDUZdEm1EKxUuJJEWzguA5Y8GgkHjAN7Xw==
X-Received: by 2002:a05:6602:6c15:b0:7eb:6cbc:8856 with SMTP id ca18e2360f4ac-7f13edb1690mr76350439f.2.1718735405750;
        Tue, 18 Jun 2024 11:30:05 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:b5f:d6ad:8a73:5578])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ebdbaca62esm283635839f.36.2024.06.18.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 11:30:05 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:30:02 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: mario.limonciello@amd.com
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	linux-kernel@vger.kernel.org, mmikowski@kfocus.org,
	Perry.Yuan@amd.com
Subject: Re: [PATCH] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnHSKiaYf2tIQo58@kf-XE>
References: <ZnD22b3Br1ng7alf@kf-XE>
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>

On Tue, Jun 18, 2024 at 12:09:19PM -0500, Mario Limonciello wrote:
> On 6/17/2024 21:54, Aaron Rainbolt wrote:
> > acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> > 
> > The _OSC is supposed to contain a bit indicating whether the hardware
> > supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> > be considered absent. This results in severe single-core performance
> > issues with the EEVDF scheduler.
> > 
> > To work around this, provide a new kernel parameter,
> > "processor.ignore_osc_cppc_bit", which may be used to ignore the _OSC
> > CPPC v2 bit and act as if the bit was enabled. This allows CPPC to be
> > properly detected even if not "enabled" by _OSC, allowing users with
> > problematic hardware to obtain decent single-core performance.
> > 
> > Tested-by: Michael Mikowski <mmikowski@kfocus.org>
> > Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>
> 
> This sounds like a platform bug and if we do accept a patch like this I
> think we need a lot more documentation about the situation.

It is a platform bug, yes. See my previous email,                      
https://lore.kernel.org/linux-acpi/d01b0a1f-bd33-47fe-ab41-43843d8a374f@kfocus.org/T/#u
(I meant to send this email as a reply to that one, but failed to do so.)

> Can you please share more information about your hardware:
> 1) Manufacturer?

Carbon Systems, models Iridium 14 and Iridium 16.

> 2) CPU?

Intel Core i5-13500H.

> 3) Manufacturer firmware version?

The systems use an AMI BIOS with version N.1.10CAR01 according to
dmidecode. This is the latest BIOS available from the manufacturer.

> 4) If it's AMD what's the AGESA version?

Both affected systems are Intel-based and use heterogenous cores, not AMD.

> And most importantly do you have the latest system firmware version from
> your manufacturer?  If not; please upgrade that first.

We are using the latest firmware. (We're trying to work with the ODM to
potentially get a firmware update, but since this affects more than just
us and a firmware update may not be possible for everyone, this would
likely be worth providing a kernel-level workaround for.)

I can easily provide more detailed information - would the full output of
'dmidecode' and 'acpidump' be useful?


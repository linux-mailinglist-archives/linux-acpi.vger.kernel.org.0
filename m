Return-Path: <linux-acpi+bounces-14968-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EAEAF6E00
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 11:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36B616DA80
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D24424A054;
	Thu,  3 Jul 2025 09:01:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEB42DE719;
	Thu,  3 Jul 2025 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533268; cv=none; b=tP3mFeMhKPvDBHJaFN3gPm0rQ5zCPfI/tVF3/xb6GO4N2zwKOu+lZV6iNEzkwRGPCVu28NKor8IBvaGP74k6oIY1lR+GuzJx+jeTorNTwcRI124La7vAuzQtzTC+JY4Q+S58j5s6IKkxjhBMAw1N1BHMG/v790NeXws8At1zsxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533268; c=relaxed/simple;
	bh=Mo+wz9nu02dz+aoXNRKbGA/Ov71kuD9aMYcHBnQD4H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr0BKzBX1iEFrCZnPs6VIxAVtEdU2a+yfzhkKeMu7aG5NxV62zGfmi9l6aI4A7ocZKHyDOnMIY3iM6vwACJXKCesWE92Rj/jQC7qXxt4QZ510+mbvlS+v2+cJBMpypXo/F6lu/vQY/my8hNxEBpWkInJUKHh0oAIRCeWO4C8cWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so1651913a12.1;
        Thu, 03 Jul 2025 02:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751533265; x=1752138065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVlu1b7wLj7VB8eQ78+9zAplW6+7Gp9At3TBS0dvb98=;
        b=sNSFo8RynMCiLtr+wIHbtGUCzpfMCJl9opNH4fkMo2vFm4ZwPafmtgRbFXCRd9hTn/
         GWcEpH/SLB6k6euRRWEAkRKOcgAo34DBcNJ7udixCmVLaZjCI7L4sS00qZXM3gC3nls+
         jMI4Z50Hkai88vL0Od/K1DCixIeG4xWgBZxOg5oZRh6XYiOoBW8dkokWxUsyS7+Z9+bD
         iOwevWz272tCNvvjnXvr7vGeNH2MCREvF3heEiyOBvvhv+IT/NF+MBXyUmxDjXVjtJmo
         fwNQNBnUyquB8qyWpAqKZDgcLPl4Rfz0A1BfeEYneR6/l2B8CDOeukokN/vzRJGSOlN5
         ki6g==
X-Forwarded-Encrypted: i=1; AJvYcCUqsrX+rSxOV23KCTcdAMZgANm3MbwvbO9NUQPKEKmN2VjkfHZGgc5biEtInYOaSrkNF4QQv/5APm6gwM2t@vger.kernel.org, AJvYcCXPtGbE5FMTWfpr1y5K/eDSpWap9wAE87Ei1L3dlriQ3IAoYHXPfIAT0oom8BP2l/ZzdCDhxLpzCwKg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5TT5PkeSt97g0z/8NUA1wpSYWDCVoC5X22/Vn8VzRfRVHfZf
	hE3WMGYMLLnjuHyvwn5s1SRmnh4VXsINktaASgOPocrR3LydbryEKrBfYVJeew==
X-Gm-Gg: ASbGncty8+jVP57VZRFy0qSbRGhTSzAME5jox/SiaHRrRwh6GHTTkxdFMLgsXGa+vbj
	HacM2R2a8DgWqe16ulXBDveUnXbjPXmpvYodxxjmFz/7kYsuTRu0N0YvTHO1v+0+TktKGgk6gG0
	3TMDZPTh+MPd/x6lL7LdWg9o0j17FNSxt8LxpA1OewM4qJDsY+n9Lfno7yb58igx3+j9WLNANDC
	dhRsS6q+kGU9Nur3uTwB7627FIfD93Qw7CGiaDXRRCOVDNYkdD+3vPoRuShmljKlc/nF5yjQWmX
	c6SLr0Hfo4+dskudwZO4dMIsg6ZmXiOwSXw1LfqlK8bIxTqt7ghD
X-Google-Smtp-Source: AGHT+IFd8yJMSsvw+b+7huXpKjDEedjWi+BrkvfSt+aeRPnS4MbkoDhJCGgrmKFvA/W3V4LkP63Z3w==
X-Received: by 2002:a17:907:7f0e:b0:ad8:959c:c567 with SMTP id a640c23a62f3a-ae3dcabcaf6mr204783166b.10.1751533264617;
        Thu, 03 Jul 2025 02:01:04 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3c915bce9sm228479466b.116.2025.07.03.02.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 02:01:04 -0700 (PDT)
Date: Thu, 3 Jul 2025 02:01:01 -0700
From: Breno Leitao <leitao@debian.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, kbusch@kernel.org, rmikey@meta.com
Subject: Re: [PATCH] acpi/ghes: add TAINT_MACHINE_CHECK on GHES panic path
Message-ID: <aGZGzaGeldWYHOwG@gmail.com>
References: <20250702-add_tain-v1-1-9187b10914b9@debian.org>
 <aGVe4nv18dRHHV16@agluck-desk3>
 <aGVq6khN+QdqD5Aj@gmail.com>
 <aGVyX0jqwTPkCVqY@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGVyX0jqwTPkCVqY@agluck-desk3>

On Wed, Jul 02, 2025 at 10:54:39AM -0700, Luck, Tony wrote:
> On Wed, Jul 02, 2025 at 10:22:50AM -0700, Breno Leitao wrote:
> > On Wed, Jul 02, 2025 at 09:31:30AM -0700, Luck, Tony wrote:
> > > On Wed, Jul 02, 2025 at 08:39:51AM -0700, Breno Leitao wrote:
> > > So unless someone feels it would be better to create a new TAINT
> > > flag (TAINT_FATAL_GHES? TAINT_FIRMWARE_REPORTED_FATAL_ERRROR?)
> > > then this seems OK to me.
> > 
> > Thanks. That brings another topic. I am seeing crashes and warnings that
> > are only happening after recoverable errors. I.e, there is a GHES
> > recoverable error, and then machine crashes minutes later. A classical
> > example is when the PCI downstream port disappear, and recovers later,
> > re-enumerating everything, which is simply chaotic.
> > 
> > I would like to be able to correlate the crash/warning with a machine
> > that had a recoverable error. At scale, this improves the kernel
> > monitoring by a lot.
> > 
> > So, if we go toward using TAINT_FATAL_GHES, can we have two flavors?
> > TAINT_FATAL_GHES_RECOVERABLE and TAINT_FATAL_GHES_FATAL?
> 
> Do you really want to TAINT for recoverable errors? If most errors
> are successfully recovered, then a TAINT indication that a recovery
> happened a week ago would be misleading.
> 
> Maybe better to save a timestamp for when the most recent recoverable
> error occurred, then compare that against the current time in panic()
> path and print warning if the recoverable error was "recent" (for
> some TBD value of "recent").

Thanks for your insight.

I believe it would be simpler to just add support for a TAINT that the
hardware got an error while this kernel was booted. That is what I would
like to indicate to the user.

The user shouldn't not correlate that to the crash or panic. As you
said, the hardware error could have happened weeks ago and completely
unrelated.

Tainting the kernel that a hardware error happen must NOT imply that the
kernel crashed because of the hardware error.

Something similar happens with proprietary module taint
(PROPRIETARY_MODULE). The kernel is tainted when an proprietary module
is loaded, but, it does not imply that the crash came because of the
external module being loaded. It is just an extra information that will
help the investigation later.

In summary, I don't think we should solve the problem of correlation
here, given it is not straightforward. I just want to tag that the
hardware got an error while the kernel was running, and the operator can
use this information the way they want.

Am I on the right track?

Thanks for the discussion,
--breno




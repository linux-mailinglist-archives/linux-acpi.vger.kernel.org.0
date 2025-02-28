Return-Path: <linux-acpi+bounces-11644-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF5A4A1CE
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 19:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B39A175A62
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 18:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825B627CCD8;
	Fri, 28 Feb 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PlQQ6lq4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88E27CCD1
	for <linux-acpi@vger.kernel.org>; Fri, 28 Feb 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768002; cv=none; b=RkLvH9NeTNnTcjiDU8ZOyzYX1zUV/lFb/6y7Ek50rW30dRLV/QSkYTsCaDbL8DKAck/Ijz+EeQCHJPckV0nVO5RAFAN8uIA4mxpS15jLclUBgcc6U1WqXR0rhQftJFbL3eLjbMaizTfyrKIVuEXlF6lgh6AYkIquFZV67dW1yzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768002; c=relaxed/simple;
	bh=qcwdZtGVQ0KgGKyuKhrX6OsMVbA16XsY4lfZ9C5DJmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lh+Weiij94KPgqQVWSefAhc/bWasVFc7KcAByCUQS0pg7OW/sHbMPJsrIqTNe6vYVgUCdqZtBjaI9CEF8kzJ47REkhdgxBpXbIDtmP2ljG5ZhfetzKVkIjX0GPMQd5OWVdectcd39+Ys33TllqebqMu8MrXrPnYq+41qjdaX0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PlQQ6lq4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22382657540so396255ad.2
        for <linux-acpi@vger.kernel.org>; Fri, 28 Feb 2025 10:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740768000; x=1741372800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MgXcypmlC80hGAB4x9hOpR3eZk+5FpjuFNPIV11Z1M=;
        b=PlQQ6lq4phST4QUyGPlqjtFWY5lKF9f9EnpeZbwp/wtNSYbN2jovyGsurb/bvP4WJh
         NkKHOPvfPtFvcprWaEhZ0OMebi1PxPiIgyYviGp2ciLKWt1/DlS5CD8H2YOeSZVze12H
         DiouLZVYpZBukUQ9P0OqkUyhMurEZFGiJ+lG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740768000; x=1741372800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MgXcypmlC80hGAB4x9hOpR3eZk+5FpjuFNPIV11Z1M=;
        b=wb04YMiqu8O9QHoW8GB89isj8Ls8U/buY325pLrWFbQ7miBdqPicmcwzv9RBSJWKNT
         NvfzFi+uZsfRt0usuXa963c+GWzA9wUxM+qoSGWyi/YSnookHKZbsUYH6GahI6LVZSB1
         9LR2OD7T+EZsa+WlCxViN0M9GYEWL2+jvdP4AqKLwxmYbkKpeJpU0TR7LIT4q6e79KDN
         A6ieEZ+zY6UsOr51CLD1tTwEDGj6FMnowRTZJ69kpFEGBsjVTMIXlLX8irTtGqon+rky
         DnlXUzOsUlvX56S4VM34e5Bj4hQ82hLCsbuaiIQ+gBctm3bJFz6a9s5UONV0sOoCZFsJ
         9KNA==
X-Forwarded-Encrypted: i=1; AJvYcCVkNwtl7UCedKDpKzwQn/0al/G7Sj/Uz2mNXfRJiFLqbECdgRExa0KdUeXj8Zhds4y1LApAAuE8olJx@vger.kernel.org
X-Gm-Message-State: AOJu0YzORDuVvXO7VX1BeY5G/XAo90TfdtIg0BRsPm0OzQ/9+U36qunJ
	3L8rKK5KPRw+z+Gx5KMzU6qQage6+hsK7SD7Jr0mj6JgvzRHpJTICnVTKdItWg==
X-Gm-Gg: ASbGncsDV67GUXLNdafXNv23p827XJdkjWY1kyq6gmZgGtAgLZcd8Bh/tWxZGsepNOf
	QOePtw8zwhKOBz8eHyVwcq3Ki8/+9MY6iyfzA9nC02LBppiYgxX3zA9WO/fkW9Ade0VPPuBOnfu
	FaMX6tzpmjyPLRwXaoZjofaIVLVUqC6aK8s85CPmJ7MleDhK3pJbyKHTcxXRU4NEwxpSRAdnqoN
	RHrrEH7EP5AqYJixF5zY1abKTKAP2GOPZAlZCCL0yS7Fpi9LFx/3MRnnnbXeCemVJZQpXlHLjUv
	IYoRpaE/kLiDWUm4CWPImg6le1UqoIRYywtC63IAibVBlh98QqjOLf6E1UZhdbq+
X-Google-Smtp-Source: AGHT+IEGJtn6vN/4w0fDLkqBf4MJwKKbPjoLNVSL+iAUMScyBl+Eyxc6RicCXt2Q7IaYZNqA3fSDyA==
X-Received: by 2002:a17:902:d4cb:b0:21f:b6f:3f34 with SMTP id d9443c01a7336-22368f9d88fmr66301635ad.15.1740768000116;
        Fri, 28 Feb 2025 10:40:00 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:fd9b:307f:4caf:4649])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2235050fca1sm36748085ad.211.2025.02.28.10.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 10:39:59 -0800 (PST)
Date: Fri, 28 Feb 2025 10:39:57 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	lukas@wunner.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v5] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <Z8IC_WDmix3YjOkv@google.com>
References: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>
 <20250228174509.GA58365@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228174509.GA58365@bhelgaas>

Hi Bjorn,

On Fri, Feb 28, 2025 at 11:45:09AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 26, 2024 at 03:17:11PM -0800, Brian Norris wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Unlike ACPI based platforms, there are no known issues with D3Hot for
> > the PCI bridges in Device Tree based platforms. 
> 
> Can we elaborate on this a little bit?  Referring to "known issues
> with ACPI-based platforms" depends on a lot of domain-specific history
> that most readers (including me) don't know.

Well, to me, the background here is simply the surrounding code context,
and the past discussions that I linked:

https://lore.kernel.org/linux-pci/20240227225442.GA249898@bhelgaas/

The whole reason we need this patch is that:
(a) there's some vaguely specified reason this function (which prevents
    standard-specified behavior) exists; and
(b) that function includes a condition that allows all systems with a
    DMI/BIOS newer than year 2015 to use this feature.

Digging a bit further, it seems like maybe the only reason this feature
is prevented on DT systems is from commit ("9d26d3a8f1b0 PCI: Put PCIe
ports into D3 during suspend"), where the subtext is that it was written
by and for Intel in 2016, with an arbitrary time-based cutoff ("year
this was being developed") that only works for DMI systems. DT systems
do not tend to support DMI.

If any of this is what you're looking for, I can try to
copy/paste/summarize a few more of those bits, if it helps.

> I don't think "ACPI-based" or "devicetree-based" are good
> justifications for changing the behavior because they don't identify
> any specific reasons.  It's like saying "we can enable this feature
> because the platform spec is written in French."

AIUI, It's involved because of the general strategy of this function
(per its comments, "recent enough PCIe ports"). So far, it sounds like
that reason (presumably, old BIOS with poor power management code)
doesn't really apply to a system based on device tree, where the power
management code is mostly/entirely in the OS.

But really, the original commit doesn't actually state reasons, so maybe
the "known issues" phrasing could be weakened a bit, to avoid implying
there were any stated reasons.

> > Past discussions (Link [1]) determined the restrictions around D3
> > should be relaxed for all Device Tree systems. 
> 
> This is far too generic a statement for me to sign up to, especially
> since "all Device Tree systems" doesn't say anything at all about how
> any particular hardware works or what behavior we're relying on.
> 
> We need to say something about what D3hot means (i.e., only message
> and type 0 config requests accepted) and that we know anything below
> the bridge is inaccessible in D3hot and why that's OK.  E.g., maybe we
> only care about wakeup requests and we know those still work with the
> bridge in D3hot because XYZ.

The context of this function is that it applies to situations where we
are considering runtime all of the PCI hierarchy beneath the port. So
yes, it applies in situations where we will wake device(s) by PMCSR, or
they will request wakeup via PME, WAKE#, etc.

Beyond that ... I don't really know what to say. This is how the spec
says things should work, and AFAICT, the only reason we don't do that is
because the feature writer was being conservative and happened to assume
DMI is always present.

Brian


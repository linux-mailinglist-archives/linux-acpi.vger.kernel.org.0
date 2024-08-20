Return-Path: <linux-acpi+bounces-7726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FDB958D0E
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 19:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1660285F14
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59061C3F2B;
	Tue, 20 Aug 2024 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+9Ng/g4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED11BA87C;
	Tue, 20 Aug 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174290; cv=none; b=qdqHOCI0SlJwscZWW4GnTXLjAnVYBgQr8r7hOQB03DB6nUtcbrZXAycIgVhSPqSGi51K/rNEeVpXNuORZ/bnAU8CualQpT/5GGXZXxOZCjBRbX1RZmLS5NHSA/sUavgqPthOXRSBQZ7q34SGTu+BeR7pNXJdHhz/rTn7ifuFsD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174290; c=relaxed/simple;
	bh=slz9l2RX+N0FmQXjCf6NH6EUr44XL+MqY2t/iaXXVa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpXHC8oMoWvBaDUD9i5s+cZQgtPoM/NXMa6BTIY6uRnlp3zPnZS3aDKZrDknigqxmUdisUdtA8ZLLsO/R534K0FJN/hlXRRg7v/93p+ejE6HwIEKj6aNHgsbZvFwL/eAEnIdKTPL3aT7V8Wk1CTq5NAE0d5D9YvlCcsa0/YapWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+9Ng/g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5AFC4AF0E;
	Tue, 20 Aug 2024 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724174289;
	bh=slz9l2RX+N0FmQXjCf6NH6EUr44XL+MqY2t/iaXXVa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+9Ng/g4B4rsICd68chNTDeL5s7L1YFbZ/Fd/tCMJVQHCM8wN0AAMSIC9qH1yBAt5
	 +J5HcY0lntOU4Ea4jTTpVPWeo6h9+Of3J78Zz9mSqWiQszVjLFGtAspjN5ZpiXgD05
	 r+0sitG/UC+gvt22Ommdtae8oDXSdhp2adT5o6kgUDvsQaEJuu4MhhPIAqet5nqssR
	 CIvp8+vDMLrYPr9Zz/Vz6gO2FTrnEQNvtqJraR9yhb4Dt6adBkbUXEcXLXCn/Txiu1
	 55snEzTBLR8afBJwT88ibIZzwW1w3iKjjYJWgfYAkJjok3kEOhMGFQ3uPtvv5MzPcZ
	 Tvx6v6p1kzaOQ==
Date: Tue, 20 Aug 2024 10:18:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Pearson <markpearson@lenovo.com>, Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, stable@vger.kernel.org,
	John Rowley <lkml@johnrowley.me>
Subject: Re: [PATCH] ACPI: platform-profile: Fix CFI violation when accessing
 sysfs files
Message-ID: <20240820171806.GA4065547@thelio-3990X>
References: <20240819-acpi-platform_profile-fix-cfi-violation-v1-1-479365d848f6@kernel.org>
 <2024082034-bullfight-pureness-3ada@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024082034-bullfight-pureness-3ada@gregkh>

Hi Greg,

On Tue, Aug 20, 2024 at 06:15:52AM +0200, Greg KH wrote:
> On Mon, Aug 19, 2024 at 12:09:22PM -0700, Nathan Chancellor wrote:
> > When an attribute group is created with sysfs_create_group(), the
> > ->sysfs_ops() callback is set to kobj_sysfs_ops, which sets the ->show()
> > and ->store() callbacks to kobj_attr_show() and kobj_attr_store()
> > respectively. These functions use container_of() to get the respective
> > callback from the passed attribute, meaning that these callbacks need to
> > be the same type as the callbacks in 'struct kobj_attribute'.
> > 
> > However, the platform_profile sysfs functions have the type of the
> > ->show() and ->store() callbacks in 'struct device_attribute', which
> > results a CFI violation when accessing platform_profile or
> > platform_profile_choices under /sys/firmware/acpi because the types do
> > not match:
> > 
> >   CFI failure at kobj_attr_show+0x19/0x30 (target: platform_profile_choices_show+0x0/0x140; expected type: 0x7a69590c)
> > 
> > This happens to work because the layout of 'struct kobj_attribute' and
> > 'struct device_attribute' are the same, so the container_of() cast
> > happens to allow the callbacks to still work.
> 
> Please note that this was an explicit design decision all those years
> ago, it's not just "happening" to work by some accident.  It was just
> done way before anyone thought of CFI-like things.

Ack, thanks for the additional context! I can shore up this block with
something like (wording improvements welcome):

  There is no functional issue from the type mismatch because the layout
  of 'struct kobj_attribute' and 'struct device_attribute' are the same,
  so the container_of() cast does not break anything aside from CFI.

which might sound less accusatory (not my intention). I just remember
getting feedback on a patch similar to this a long time ago (perhaps
from Kees?) around "why does this even work as is if the types are
wrong?".

> > 
> > Change the type of platform_profile_choices_show() and
> > platform_profile_{show,store}() to match the callbacks in
> > 'struct kobj_attribute' and update the attribute variables to match,
> > which resolves the CFI violation.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
> > Reported-by: John Rowley <lkml@johnrowley.me>
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/2047
> > Tested-by: John Rowley <lkml@johnrowley.me>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/acpi/platform_profile.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> > index d2f7fd7743a1..11278f785526 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -22,8 +22,8 @@ static const char * const profile_names[] = {
> >  };
> >  static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
> >  
> > -static ssize_t platform_profile_choices_show(struct device *dev,
> > -					struct device_attribute *attr,
> > +static ssize_t platform_profile_choices_show(struct kobject *kobj,
> > +					struct kobj_attribute *attr,
> >  					char *buf)
> >  {
> >  	int len = 0;
> > @@ -49,8 +49,8 @@ static ssize_t platform_profile_choices_show(struct device *dev,
> >  	return len;
> >  }
> >  
> > -static ssize_t platform_profile_show(struct device *dev,
> > -					struct device_attribute *attr,
> > +static ssize_t platform_profile_show(struct kobject *kobj,
> > +					struct kobj_attribute *attr,
> >  					char *buf)
> >  {
> >  	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
> > @@ -77,8 +77,8 @@ static ssize_t platform_profile_show(struct device *dev,
> >  	return sysfs_emit(buf, "%s\n", profile_names[profile]);
> >  }
> >  
> > -static ssize_t platform_profile_store(struct device *dev,
> > -			    struct device_attribute *attr,
> > +static ssize_t platform_profile_store(struct kobject *kobj,
> > +			    struct kobj_attribute *attr,
> >  			    const char *buf, size_t count)
> >  {
> >  	int err, i;
> > @@ -115,12 +115,12 @@ static ssize_t platform_profile_store(struct device *dev,
> >  	return count;
> >  }
> >  
> > -static DEVICE_ATTR_RO(platform_profile_choices);
> > -static DEVICE_ATTR_RW(platform_profile);
> > +static struct kobj_attribute attr_platform_profile_choices = __ATTR_RO(platform_profile_choices);
> > +static struct kobj_attribute attr_platform_profile = __ATTR_RW(platform_profile);
> 
> I understand your need/want for this, but ick, is there any way to get
> back to using 'struct device' and not "raw" kobjects here?  That's what
> the code should be using really.

Not sure, I did not write this driver and I am unfamiliar with the
'struct device' infrastructure. I see some other drivers in drivers/acpi
and drivers/firmware that use raw kobjects due to sysfs_create_group()
under firmware_kobj, so this does not necessarily feel out of place. If
I got some hints, I could potentially try to do that conversion and have
John test it with CFI (since I do not have this hardware) but I would
think this could still be necessary for stable depending on how that
conversion turns out.

Cheers,
Nathan


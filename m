Return-Path: <linux-acpi+bounces-7697-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1AE957C50
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 06:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BC61C22FC7
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 04:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF4641C79;
	Tue, 20 Aug 2024 04:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ib9BUAFd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DD2F5E;
	Tue, 20 Aug 2024 04:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724127365; cv=none; b=TVAl4QcWwRvVA7QpJ76jUUXN2kIR3lK2+sx18gRnE2IjgRPSsffdWuO7GVDy7zE7wJnVK4ht4LVPORBf7trlLgGFD5vUCmQbpHcuqLXjWzjG1VQvtdDN11byiB33+0euYbgrZaYLni113MrI2JPh5/ORF0cnNFcczuAdMhwvHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724127365; c=relaxed/simple;
	bh=AGa3YhfBqQHIC8r3pvSt8hZ1jUBw1AJBBqGQCs2wo98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsY8IDDm05Ru/HObBEad6Phnhon6PpgniNf9/BOHa98YQiabKluZi4dNQeoIVmgrzxhnyINM+iGRPpGf+IelplcBuPw2jdkLUZC34FLrT4qYjgg0Ujz12bZK9SIVfkiGi8Mklz8Noa+qQJ+qi6S9UiyNgNDPRh5TpX/QA22wL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ib9BUAFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C98C4AF09;
	Tue, 20 Aug 2024 04:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724127364;
	bh=AGa3YhfBqQHIC8r3pvSt8hZ1jUBw1AJBBqGQCs2wo98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ib9BUAFdVkVdBgf92ngVXaz9/zKAZE+WtXLpxOj5r/PuW0XRmqPX8rTqYGWkv0MC7
	 sgk8KQo/vj6VGCdUkMkZfY3D7OVXThlaPhtqY4AM3Vv+hY4Cn15RpD6mhz8shSGIDb
	 gi/nHa3aFCQwyI2yentY9SjEj4nIuSkYpkrfX/OQ=
Date: Tue, 20 Aug 2024 06:15:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Pearson <markpearson@lenovo.com>, Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, stable@vger.kernel.org,
	John Rowley <lkml@johnrowley.me>
Subject: Re: [PATCH] ACPI: platform-profile: Fix CFI violation when accessing
 sysfs files
Message-ID: <2024082034-bullfight-pureness-3ada@gregkh>
References: <20240819-acpi-platform_profile-fix-cfi-violation-v1-1-479365d848f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-acpi-platform_profile-fix-cfi-violation-v1-1-479365d848f6@kernel.org>

On Mon, Aug 19, 2024 at 12:09:22PM -0700, Nathan Chancellor wrote:
> When an attribute group is created with sysfs_create_group(), the
> ->sysfs_ops() callback is set to kobj_sysfs_ops, which sets the ->show()
> and ->store() callbacks to kobj_attr_show() and kobj_attr_store()
> respectively. These functions use container_of() to get the respective
> callback from the passed attribute, meaning that these callbacks need to
> be the same type as the callbacks in 'struct kobj_attribute'.
> 
> However, the platform_profile sysfs functions have the type of the
> ->show() and ->store() callbacks in 'struct device_attribute', which
> results a CFI violation when accessing platform_profile or
> platform_profile_choices under /sys/firmware/acpi because the types do
> not match:
> 
>   CFI failure at kobj_attr_show+0x19/0x30 (target: platform_profile_choices_show+0x0/0x140; expected type: 0x7a69590c)
> 
> This happens to work because the layout of 'struct kobj_attribute' and
> 'struct device_attribute' are the same, so the container_of() cast
> happens to allow the callbacks to still work.

Please note that this was an explicit design decision all those years
ago, it's not just "happening" to work by some accident.  It was just
done way before anyone thought of CFI-like things.

> 
> Change the type of platform_profile_choices_show() and
> platform_profile_{show,store}() to match the callbacks in
> 'struct kobj_attribute' and update the attribute variables to match,
> which resolves the CFI violation.
> 
> Cc: stable@vger.kernel.org
> Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
> Reported-by: John Rowley <lkml@johnrowley.me>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2047
> Tested-by: John Rowley <lkml@johnrowley.me>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/acpi/platform_profile.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index d2f7fd7743a1..11278f785526 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -22,8 +22,8 @@ static const char * const profile_names[] = {
>  };
>  static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>  
> -static ssize_t platform_profile_choices_show(struct device *dev,
> -					struct device_attribute *attr,
> +static ssize_t platform_profile_choices_show(struct kobject *kobj,
> +					struct kobj_attribute *attr,
>  					char *buf)
>  {
>  	int len = 0;
> @@ -49,8 +49,8 @@ static ssize_t platform_profile_choices_show(struct device *dev,
>  	return len;
>  }
>  
> -static ssize_t platform_profile_show(struct device *dev,
> -					struct device_attribute *attr,
> +static ssize_t platform_profile_show(struct kobject *kobj,
> +					struct kobj_attribute *attr,
>  					char *buf)
>  {
>  	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
> @@ -77,8 +77,8 @@ static ssize_t platform_profile_show(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", profile_names[profile]);
>  }
>  
> -static ssize_t platform_profile_store(struct device *dev,
> -			    struct device_attribute *attr,
> +static ssize_t platform_profile_store(struct kobject *kobj,
> +			    struct kobj_attribute *attr,
>  			    const char *buf, size_t count)
>  {
>  	int err, i;
> @@ -115,12 +115,12 @@ static ssize_t platform_profile_store(struct device *dev,
>  	return count;
>  }
>  
> -static DEVICE_ATTR_RO(platform_profile_choices);
> -static DEVICE_ATTR_RW(platform_profile);
> +static struct kobj_attribute attr_platform_profile_choices = __ATTR_RO(platform_profile_choices);
> +static struct kobj_attribute attr_platform_profile = __ATTR_RW(platform_profile);

I understand your need/want for this, but ick, is there any way to get
back to using 'struct device' and not "raw" kobjects here?  That's what
the code should be using really.

thanks,

greg k-h


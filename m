Return-Path: <linux-acpi+bounces-10997-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B7EA30394
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 07:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157BE1884F11
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 06:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75B71E98FF;
	Tue, 11 Feb 2025 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Z2ikvrw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8156E1D54C2;
	Tue, 11 Feb 2025 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255314; cv=none; b=a+dxJPtIfgJhbvyIsNSSLbKLYgwQb1UTO5s2NndtznqTJUq3IxECLa4BP7kkL+69jYS+MHiYNu+Huk5XVB6PHna9ZSId8UtZo+epXKcbe/FIcuPtiFvBMXjytHEihFQ+uSAl1VsJes5qMw3jVkkj5QSMoxHW+TS1yRHzTbAvPWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255314; c=relaxed/simple;
	bh=Vi3lGBXEhmoQzEyU+5dzG33UvVcHa1ftzEK7IGthpzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwBJ366vHTfZaCDUXDnGEw7SlO/hC/3POhw9lujV0c16ANExLDO5d361lVHptS6+r6QF4i+SecvhpdDJR4wtkxOA+WwLNuXYlPqASGtZGd/mFAVOFsmOy7CUuSa57EYTldXolwLPUX2f4inKjMeqXG7slvA0+ZoSk/x9IxhOdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Z2ikvrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BE4C4CEDD;
	Tue, 11 Feb 2025 06:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739255314;
	bh=Vi3lGBXEhmoQzEyU+5dzG33UvVcHa1ftzEK7IGthpzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1Z2ikvrw7YUYBNUkp4Lj4Q9etGh7f/7BSJDQUzNnYKlE8chnhTl6L1WeaTambTQlk
	 QVY73jj7nHzMtTXRgWJDqvRoEmPUvHuJtT83cFHHPzAvXgM8BxknQ8V4DAPROARruA
	 hr9Jicn/LIPPM3SajdgcEDHVeZ73L5/6nymSXZfk=
Date: Tue, 11 Feb 2025 07:27:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, stable@vger.kernel.org,
	John Rowley <lkml@johnrowley.me>
Subject: Re: [PATCH v3] ACPI: platform-profile: Fix CFI violation when
 accessing sysfs files
Message-ID: <2025021105-simply-stubbed-1744@gregkh>
References: <20250210-acpi-platform_profile-fix-cfi-violation-v3-1-ed9e9901c33a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-acpi-platform_profile-fix-cfi-violation-v3-1-ed9e9901c33a@kernel.org>

On Mon, Feb 10, 2025 at 09:28:25PM -0500, Nathan Chancellor wrote:
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
> There is no functional issue from the type mismatch because the layout
> of 'struct kobj_attribute' and 'struct device_attribute' are the same,
> so the container_of() cast does not break anything aside from CFI.
> 
> Change the type of platform_profile_choices_show() and
> platform_profile_{show,store}() to match the callbacks in
> 'struct kobj_attribute' and update the attribute variables to match,
> which resolves the CFI violation.

Nice catch.

> Cc: stable@vger.kernel.org
> Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
> Reported-by: John Rowley <lkml@johnrowley.me>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2047
> Tested-by: John Rowley <lkml@johnrowley.me>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v3:
> - Rebase on 6.14-rc1, which includes updates to the driver to address
>   Greg's previous concerns but this change is still needed for the
>   legacy sysfs interface. v2 can be used for the stable backport.
> - Link to v2: https://lore.kernel.org/r/20241118-acpi-platform_profile-fix-cfi-violation-v2-1-62ff952804de@kernel.org

I'll never find that, so be prepared for a "FAILED" email when this hits
Linus's tree :)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


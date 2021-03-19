Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9123C3415EC
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 07:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhCSGff (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 02:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233993AbhCSGfQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Mar 2021 02:35:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F140864F6B;
        Fri, 19 Mar 2021 06:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616135715;
        bh=pzlu7maINKdZ8i13FcK7WXSNkVOhKs0PqBh8sl3cZ1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hm7WwAy+z+u2ReeF5xY+gtvINbGXHyjvnwgD5k59Ih+qwMa0EzldZ4gk7Kt+G/M95
         +H7BUs0P3kkxOaAMl2efx1EXMn/IcYBFHN7mChE8zYn4t8FQQszDwFpO91qGSGx5Hw
         /YVvExIcHgzrIFDzs8PsO7xIbtwl5QRtDUqOol/U=
Date:   Fri, 19 Mar 2021 07:35:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     tim.c.chen@linux.intel.com, catalin.marinas@arm.com,
        will@kernel.org, rjw@rjwysocki.net, vincent.guittot@linaro.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        lenb@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        msys.mizuma@gmail.com, valentin.schneider@arm.com,
        jonathan.cameron@huawei.com, juri.lelli@redhat.com,
        mark.rutland@arm.com, sudeep.holla@arm.com,
        aubrey.li@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, xuwei5@huawei.com, prime.zeng@hisilicon.com,
        guodong.xu@linaro.org, yangyicong@huawei.com,
        liguozhu@hisilicon.com, linuxarm@openeuler.org, hpa@zytor.com
Subject: Re: [RFC PATCH v5 1/4] topology: Represent clusters of CPUs within a
 die
Message-ID: <YFRGIedW1fUlnmi+@kroah.com>
References: <20210319041618.14316-1-song.bao.hua@hisilicon.com>
 <20210319041618.14316-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319041618.14316-2-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 19, 2021 at 05:16:15PM +1300, Barry Song wrote:
> diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
> index b90dafc..f9d3745 100644
> --- a/Documentation/admin-guide/cputopology.rst
> +++ b/Documentation/admin-guide/cputopology.rst
> @@ -24,6 +24,12 @@ core_id:
>  	identifier (rather than the kernel's).  The actual value is
>  	architecture and platform dependent.
>  
> +cluster_id:
> +
> +	the Cluster ID of cpuX.  Typically it is the hardware platform's
> +	identifier (rather than the kernel's).  The actual value is
> +	architecture and platform dependent.
> +
>  book_id:
>  
>  	the book ID of cpuX. Typically it is the hardware platform's
> @@ -56,6 +62,14 @@ package_cpus_list:
>  	human-readable list of CPUs sharing the same physical_package_id.
>  	(deprecated name: "core_siblings_list")
>  
> +cluster_cpus:
> +
> +	internal kernel map of CPUs within the same cluster.
> +
> +cluster_cpus_list:
> +
> +	human-readable list of CPUs within the same cluster.
> +
>  die_cpus:
>  
>  	internal kernel map of CPUs within the same die.

Why are these sysfs files in this file, and not in a Documentation/ABI/
file which can be correctly parsed and shown to userspace?

Any chance you can fix that up here as well?

Also note that "list" is not something that goes in sysfs, sysfs is "one
value per file", and a list is not "one value".  How do you prevent
overflowing the buffer of the sysfs file if you have a "list"?

thanks,

greg k-h

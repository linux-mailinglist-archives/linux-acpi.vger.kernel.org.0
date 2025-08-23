Return-Path: <linux-acpi+bounces-15986-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881A9B32715
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 08:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84B6686153
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B64217F33;
	Sat, 23 Aug 2025 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tgjf3fhy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B1D1805E;
	Sat, 23 Aug 2025 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755931298; cv=none; b=I9uWhH4ueZrG8BTSXwSXKPuhrqyQJwelc94l8r4FyevS9wvVNs7eydl/KC8nyNPdbzkNc6KoliFLs1Rr5RwBAL+0v55x2K1lMWNBtjbcFM9qq39gUknrZz/oF8+aMlmqZF+GI1tpW4yH6khpKz3ss1kak45fiBTnrKt64mZ40Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755931298; c=relaxed/simple;
	bh=W2xSsVTOfKvNUrTWf8mlEmNx+BmGW/cRdE/WDxMwuCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esfQt+V7IBNNLZ4Ry6wjTHKcgnqQ1+gkMBFPI4JQJekWH9ssmCsbf+uxr1ZYBJqwRCZSn4oAC+xrbLpVMdZMFPHYP5dcyC5J5AVJhV2X1D2+BrVHEnMyrKWd8gWz+gy11Y6kFNXHLuxFLWrzs3fC3Zc/+JYiNYVug4LNn3cjQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tgjf3fhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EA8C4CEE7;
	Sat, 23 Aug 2025 06:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755931297;
	bh=W2xSsVTOfKvNUrTWf8mlEmNx+BmGW/cRdE/WDxMwuCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tgjf3fhy/95FjTkdKOoetheW/ejk9PsgRrIfYJ69pvVByfXzZF+BDHUjnaUQTFFI2
	 3etnY578RIuxhkTxEA9FHO4kZx8DLjXtNyKuW91mwTNcvLc/XSosyAAO8NMKMPEebd
	 cb/ucLkpzVx2e0jIOuR3lkwh0JJ22rHLQNsd98Ww=
Date: Sat, 23 Aug 2025 08:41:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Amit Singh Tomar <amitsinght@marvell.com>,
	Baisheng Gao <baisheng.gao@unisoc.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	bobo.shaobowang@huawei.com,
	Carl Worth <carl@os.amperecomputing.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Drew Fustini <dfustini@baylibre.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Fenghua Yu <fenghuay@nvidia.com>, Hanjun Guo <guohanjun@huawei.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Koba Ko <kobak@nvidia.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Len Brown <lenb@kernel.org>, Linu Cherian <lcherian@marvell.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Peter Newman <peternewman@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rex Nie <rex.nie@jaguarmicro.com>, Rob Herring <robh@kernel.org>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Xin Hao <xhao@linux.alibaba.com>
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
Message-ID: <2025082328-acorn-wound-5c3d@gregkh>
References: <20250822153048.2287-11-james.morse@arm.com>
 <00053767-352d-4185-8542-687da0fb5e57@web.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00053767-352d-4185-8542-687da0fb5e57@web.de>

On Fri, Aug 22, 2025 at 09:55:33PM +0200, Markus Elfring wrote:
> …
> …
> > +static int mpam_msc_drv_probe(struct platform_device *pdev)
> > +{
> …
> > +	} while (0);
> > +	mutex_unlock(&mpam_list_lock);
> > +
> > +	if (!err) {
> > +		/* Create RIS entries described by firmware */
> > +		if (!acpi_disabled)
> > +			err = acpi_mpam_parse_resources(msc, plat_data);
> > +		else
> > +			err = mpam_dt_parse_resources(msc, plat_data);
> > +	}
> > +
> > +	if (!err && fw_num_msc == mpam_num_msc)
> > +		mpam_discovery_complete();
> > +
> > +	if (err && msc)
> > +		mpam_msc_drv_remove(pdev);
> > +
> > +	return err;
> > +}
> …
> 
> * Would you like to integrate anything from the following source code variant?
> 
> 	if (!err)
> 		/* Create RIS entries described by firmware */
> 		err = acpi_disabled
> 		      ? mpam_dt_parse_resources(msc, plat_data)
> 		      : acpi_mpam_parse_resources(msc, plat_data);
> 
> 	if (err) {
> 		if (msc)
> 			mpam_msc_drv_remove(pdev);
> 	} else {
> 		if (fw_num_msc == mpam_num_msc)
> 			mpam_discovery_complete();
> 	}
> 
> * How do you think about to increase the application of scope-based resource management
>   at further places?
> 
> 
> Regards,
> Markus

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot


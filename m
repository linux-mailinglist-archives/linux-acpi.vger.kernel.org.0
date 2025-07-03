Return-Path: <linux-acpi+bounces-14980-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A18AF7851
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982621C84BBA
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884962EE29E;
	Thu,  3 Jul 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgZTtq3I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3582EE287;
	Thu,  3 Jul 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554071; cv=none; b=EispTaWYD8swMAqsXXnnpbP2/ORKPZ7+P6ftlsVZxnwOmtRSQXvWaus5KsP1ZtTvRhwdoOS3Dfy5uFcGRmegIPlFuCkkcoS6CZy7Sw2psFew7SZC1Jl3tTosvwxg3T7EoZDJFGaLVNl2y60IbGNxC25UaRxRiTfg/3Nw7nlvp14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554071; c=relaxed/simple;
	bh=RafIvVbiUyoUQKQHbRbqnjeFOB2hcSEJLccEvZ3+n+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZiYNbO/rXERazWZp1wQyRp7X7HLBoFfu1bxY+nw3JaI+6Bpj4mnAlCLauT3O000kF+vLTwOnbMbttn6k7SwS6D0ihAlsYSPFe18GOmPOj1jvT3MPaH1D+Dnl3BCze8339tsYwfnvQj4it4hdU99/OHxpfhb54BgQjUMrEXt2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgZTtq3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77903C4CEE3;
	Thu,  3 Jul 2025 14:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751554071;
	bh=RafIvVbiUyoUQKQHbRbqnjeFOB2hcSEJLccEvZ3+n+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cgZTtq3IIlgui7JvyJN4aIixV24ZPVNX3mE2iFY2Geduz1t23gCzZfBxH11sZsxxU
	 0XI6riDdtTsSOHSVKlp84rU9NekMRKyHT4ZxxLDoZ6k6ELlpgDTWesSu7r5C1WFkxj
	 KxaQcRxFGj7/RrRhnrkhiFOMDxWeUUjA93aTxwchmLdyFufOu/Gk/zYusEo2W9Yw1o
	 8sHO6a0yNfXBmr1ASbw4ys+YlOg70nj+WGdtzbwPLzjk6xZFUtZxOipqjX3mOZ40A+
	 /7/aX2Z0O0s5iP4R3GmMXpWQ7FyllGbXRp9uS01Baohlo5YjOSNwXYEMdNoZx8Trh8
	 RNl4I20EQUQOg==
Message-ID: <84dfa466-d201-4a51-8794-6c64568bec95@kernel.org>
Date: Thu, 3 Jul 2025 16:47:47 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] - Multiple userspace implementations of battery
 estimate broken after "ACPI: battery: negate current when discharging"
To: Matthew Schwartz <matthew.schwartz@linux.dev>, pmarheine@chromium.org,
 Sebastian Reichel <sre@kernel.org>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
 rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org
References: <87C1B2AF-D430-4568-B620-14B941A8ABA4@linux.dev>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <87C1B2AF-D430-4568-B620-14B941A8ABA4@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Matthew,

On 3-Jul-25 3:54 AM, Matthew Schwartz wrote:
> Hello,
> 
> I installed kernel 6.15.4 to find that my battery estimate on my handheld gaming device was completely inaccurate, instead giving negative values and an unknown estimated battery life in multiple places. 
> 
> After bisecting, I landed on "ACPI: battery: negate current when discharging” as the bad commit. This commit breaks not one but several userspace implementations of battery monitoring: Steam and MangoHud. Perhaps it breaks more, but those are the two I have noticed so far. 

Thank you for reporting this.

As Rafael already indicated this patch will need to be reverted to
unbreak userspace.

But, the patch was actually doing the right thing, according to:

Documentation/ABI/testing/sysfs-class-power

What:           /sys/class/power_supply/<supply_name>/current_avg
Date:           May 2007
Contact:        linux-pm@vger.kernel.org
Description:
                Battery:
...
                Access: Read

                Valid values: Represented in microamps. Negative values are
                used for discharging batteries, positive values for charging
                batteries and for USB IBUS current.

(and the same for current_now)

and there are many power_supply fuel-gauge drivers (1) under
drivers/power/supply/ which do adhere to this specification
and report a negative current for discharging.

So if any of the userspace consumers of this API you mention
were to run on hw with these drivers the same problem will
be hit. Can you please file bugs against these userspace
projects so that they can fix this?

Regards,

Hans



1) For directly accessing fuel-gauge chips on devices where these
are directly accessible instead of being exposed through ACPI



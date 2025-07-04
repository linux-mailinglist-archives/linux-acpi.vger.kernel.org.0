Return-Path: <linux-acpi+bounces-15018-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26987AF8CC7
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 10:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD604A237F
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967212E541B;
	Fri,  4 Jul 2025 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2BcaHqy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9672E427E;
	Fri,  4 Jul 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618869; cv=none; b=dcI6yd9no8KKuUvdJm6CtGc0Xupme+adqYVcGkNSTE0RgadUh7U6Z1Il7KGKvKmbnkFR1ztjTPpRCyuENGwWLYQoL3gWZ75d47bPilmC1j6yp6swcu4polPaFtYL9y0Cab54hJzD94f+lLrlYNFMzwqkHt2zcS2FDWEheEIFI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618869; c=relaxed/simple;
	bh=O06EB5/Nw0pCMsSzvdgEuj50BETJhf7Tfv+JIgcMPGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plcaGndH7MmHnXIV07m07v/BSB9+5qxaLgekITqV25AlOBOjOIpnZsBrRYzHKIm5nhbTIUx/f9Iyd9SRWTHXnHP12YqtUh32lU32O9nqhBGnUXsw7fJ1vfuXWNcM4+/9Svh9ABsqQirw6VGKJP4rATk2J5ux4rGdxxMJGLibqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2BcaHqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAE7C4CEE3;
	Fri,  4 Jul 2025 08:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751618868;
	bh=O06EB5/Nw0pCMsSzvdgEuj50BETJhf7Tfv+JIgcMPGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z2BcaHqy9hg1ujMYB7UVs5CDxCoPVrkBsOcv0PUwUgQDMbapYmcwhfBZHPu8mUKFH
	 KNTVtzF6+LLvp0Wd6PD5zZ/ggl4A386UE7RdmUWzp5PGdLi1/xoTpHU4hVNuQZTnJE
	 hagwQXfVvferuD7maMp7jU085JQ+5oMuFw7Gu4vePSENQvzaESplLesGo5hMrMp0hd
	 qThCkQ+lwVj7Xco9YmAWK0BSta6fqsVYD0yfkUkiUNAhn3/1BBQH9vphFkwlrWoRzf
	 BkxUEdhjZMnbyZOnimkryVuY7CJSj1ngWK3TQxtLNaTQxjWBpkKIU0F8AZUTWwnh/K
	 TGoF5JCIS9drw==
Message-ID: <cd6a9d6a-d995-47c0-b474-14440c40503f@kernel.org>
Date: Fri, 4 Jul 2025 10:47:45 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] - Multiple userspace implementations of battery
 estimate broken after "ACPI: battery: negate current when discharging"
To: Peter Marheine <pmarheine@chromium.org>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
 Sebastian Reichel <sre@kernel.org>, regressions@lists.linux.dev,
 stable@vger.kernel.org, rafael.j.wysocki@intel.com,
 linux-acpi@vger.kernel.org
References: <87C1B2AF-D430-4568-B620-14B941A8ABA4@linux.dev>
 <84dfa466-d201-4a51-8794-6c64568bec95@kernel.org>
 <CAG_X_pC0jTe5fuNaK81veif-p9JeJyYpgb2E2R_RXBzfcj4_MQ@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <CAG_X_pC0jTe5fuNaK81veif-p9JeJyYpgb2E2R_RXBzfcj4_MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

On 4-Jul-25 6:56 AM, Peter Marheine wrote:
> I'm not surprised that there exist a number of userspace programs that
> assume the buggy ACPI battery behavior is the only one, but this does
> leave us in the previous situation where there's a clear bug in the
> ACPI driver.
> 
>> But, the patch was actually doing the right thing, according to:
>>
>> Documentation/ABI/testing/sysfs-class-power
> 
> This is the key issue, since it's entirely plausible for a program
> assuming non-negative battery current to run on a non-ACPI platform
> and misbehave in the same way. If we're not going to fix the ACPI
> driver to behave as specified for the kernel ABI, then the ABI needs
> to be redefined to reflect the actual behavior. It's either that or we
> give userspace an opportunity to fix itself (and I'm not sure exactly
> how that would be done such that the clients which need to be fixed
> discover that they need to be) and correct the driver's behavior
> later.

Right, this is why I asked for bugs to be filed against the problematic
userspace programs, so that we can try to fix the ACPI driver again in
say 1 or 2 years from now.

In the mean time you could submit a patch to document the known broken
behavior of the ACPI battery driver in:

Documentation/ABI/testing/sysfs-class-power

with a big warning that userspace should not rely on this behavior.

You could even document how to work around this, e.g.:

"Negative currents are always discharging. Because of the broken ACPI
battery driver behaviour positive currents should be seen as discharging
rather then charging when the "status" sysfs attribute reports discharging."

Regards,

Hans




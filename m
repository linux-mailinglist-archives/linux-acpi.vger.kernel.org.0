Return-Path: <linux-acpi+bounces-14981-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C25AF7CE4
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 17:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344C5484A95
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AA32236E3;
	Thu,  3 Jul 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wg1Xt9JB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BE19D8AC
	for <linux-acpi@vger.kernel.org>; Thu,  3 Jul 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557909; cv=none; b=lf81V35FxKQ8thS01lFfpLHCIyMp4Q0416P5ax5K6Lfl1rZdNizGweHlHbVHr5nXfccwy5EL6NoKNZW4uGr581I0/4VFyXoYLXKeNol6hcHiMCvN+sXmF2ek2kgtz8cXMwdL07IJfa55JDzvykIpuFupXeC2t+u+UiGvzrxfdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557909; c=relaxed/simple;
	bh=LNyOaCs+OmFVnvFVEO4dEL0BZ0Ry5gb+8pGSKLPK3QU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=JqbOCDUKeAxh9zlmVr+jYPtWApYV5ZWSIE+ijCyVbFsmcFwKKiwAdDu0X2G9BBZYP1b1yhVn7KqkKXvHWgcC8usX+Y00frmkYqBgd0sptQTqeQTVJpH+r7yW8QE9w+CfpCeui24HLfEFinV+nhlW58MucGaTKx4M0PBdKOPCHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wg1Xt9JB; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751557895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joibkrYbj1WNLmMPxNS9TMuLrpCkKJkcERWpD7liezM=;
	b=wg1Xt9JBP1Qgoljd8/l94iT/ffduEwSGZPkWMz1aJk0Rr+6H7xfciBCo3s0G8H7+WICWqt
	7SPma9mZfYMWCiZRW+kfZ3DbAeBI/7cT9oCkwlPKW3obM333MRjbFll1wAQLIPkb/e3hKN
	NKDTIPXAkcTx1Hg2PyRZkqVtzLcIsGI=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [REGRESSION] - Multiple userspace implementations of battery estimate broken after "ACPI: battery: negate current when discharging"
Date: Thu, 3 Jul 2025 08:51:10 -0700
Message-Id: <10A90071-DC0B-4860-845F-556A33FC79BC@linux.dev>
References: <84dfa466-d201-4a51-8794-6c64568bec95@kernel.org>
Cc: pmarheine@chromium.org, Sebastian Reichel <sre@kernel.org>,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org
In-Reply-To: <84dfa466-d201-4a51-8794-6c64568bec95@kernel.org>
To: Hans de Goede <hansg@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jul 3, 2025, at 7:47=E2=80=AFAM, Hans de Goede <hansg@kernel.org> wrote=
:
>=20
> =EF=BB=BFHi Matthew,
>=20
>> On 3-Jul-25 3:54 AM, Matthew Schwartz wrote:
>> Hello,
>>=20
>> I installed kernel 6.15.4 to find that my battery estimate on my handheld=
 gaming device was completely inaccurate, instead giving negative values and=
 an unknown estimated battery life in multiple places.
>>=20
>> After bisecting, I landed on "ACPI: battery: negate current when discharg=
ing=E2=80=9D as the bad commit. This commit breaks not one but several users=
pace implementations of battery monitoring: Steam and MangoHud. Perhaps it b=
reaks more, but those are the two I have noticed so far.
>=20
> Thank you for reporting this.
>=20
> As Rafael already indicated this patch will need to be reverted to
> unbreak userspace.
>=20
> But, the patch was actually doing the right thing, according to:
>=20
> Documentation/ABI/testing/sysfs-class-power
>=20
> What:           /sys/class/power_supply/<supply_name>/current_avg
> Date:           May 2007
> Contact:        linux-pm@vger.kernel.org
> Description:
>                Battery:
> ...
>                Access: Read
>=20
>                Valid values: Represented in microamps. Negative values are=

>                used for discharging batteries, positive values for chargin=
g
>                batteries and for USB IBUS current.
>=20
> (and the same for current_now)
>=20
> and there are many power_supply fuel-gauge drivers (1) under
> drivers/power/supply/ which do adhere to this specification
> and report a negative current for discharging.
>=20
> So if any of the userspace consumers of this API you mention
> were to run on hw with these drivers the same problem will
> be hit. Can you please file bugs against these userspace
> projects so that they can fix this?

Sure, I filed a bug with MangoHud last night about the kernel change breakin=
g the current battery logic so I will mention this concern when updating tha=
t issue, and I will also file a new bug with Steam.

Thanks,
Matt

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
> 1) For directly accessing fuel-gauge chips on devices where these
> are directly accessible instead of being exposed through ACPI


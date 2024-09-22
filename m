Return-Path: <linux-acpi+bounces-8365-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6EE97E074
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2024 09:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D872816F2
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2024 07:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DEF18E375;
	Sun, 22 Sep 2024 07:45:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0B8179BC;
	Sun, 22 Sep 2024 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726991126; cv=none; b=Q+9PJl0hseaSK72e0behJuVhIR0ffJ0/JT3t6S0RWotMHX52bsf4N0xAasVV/A4937hOZdqOdGIPNH48a0AbpjHTmSi2AX79VOnR7MgnknAIXmXDoYacYDj3iBKbqKLPBZlmkmQhEWHAXhdVq5NEeifike4IQVEYGiphVecKDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726991126; c=relaxed/simple;
	bh=SstBRO9uSGhsQP1k3Ho7AK7WFvoLvvVgCOaqRurHhVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXJf8RsHs/y9/k5n6nBYeDIZyjCngSej9y9L2cwBhWZMRzY47dz9WuFeMehj/QHjt/MgZuNd3XABcl3rHoyl9Ha72vOGFoIe7yp5pvqb7j4mxFe34MxBXlFhXLsZHjtNKHrQu/R1k4A4rVrGOpkq0Ho4Xv0f7pjPzK3i36NiGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 4F83710F262; Sun, 22 Sep 2024 03:45:18 -0400 (EDT)
Received: from 5400 (unknown [172.56.163.43])
	by spindle.queued.net (Postfix) with ESMTPSA id 0D99B10F24C;
	Sun, 22 Sep 2024 03:45:15 -0400 (EDT)
Date: Sun, 22 Sep 2024 03:45:13 -0400
From: Andres Salomon <dilinger@queued.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: mjg59@srcf.ucam.org, pali@kernel.org, rafael@kernel.org,
 lenb@kernel.org, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] platform/x86: dell-laptop: Battery hook fixes
Message-ID: <20240922034513.330343fb@5400>
In-Reply-To: <20240922064026.496422-1-W_Armin@gmx.de>
References: <20240922064026.496422-1-W_Armin@gmx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On Sun, 22 Sep 2024 08:40:23 +0200
Armin Wolf <W_Armin@gmx.de> wrote:

> This patch series fixes some issues around the battery hook handling
> inside the ACPI battery driver and the dell-laptop driver.
> 
> The first patch simplifies the locking during battery hook removal as
> a preparation for the second patch which fixes a possible crash when
> unregistering a battery hook.
> 
> The third patch allows the dell-laptop driver to handle systems with
> multiple batteries.
> 
> All patches where tested on a Dell Inspiron 3505 and appear to work.

Can you tell me more about the system? What type of battery is the second
battery, and how is it attached? What do the kernel logs look like when the
two batteries are registered? I'm still confused as to how the same
battery->dev ends up being reused for multiple physical batteries.

The patches look good to me, btw; feel free to add my Reviewed-by
if that's helpful.

Also, with the caveat that I'm not quite understanding the aforementioned
battery->dev conflict - worth noting that dell-laptop isn't the only driver
that could have this problem with multiple batteries. A quick glance
through some other drivers:

 - asus-wmi.c does basically the same thing in checking for just the first
   battery, and the comment implies that there may be multiple batteries.

 - system76.c claims that the EC only supports one battery, so maybe that
   one is okay? But to be on the safe side, it should probably do the same
   thing.

 - thinkpad_acpi.c actually supports multiple batteries, so maybe it
   doesn't have the problem. But if tpacpi_battery_probe() fails for one
   of the batteries and the battery->dev is shared between the two
   batteries, then same issue?


> 
> Changes since v1:
> - fix the underlying issue inside the ACPI battery driver
> - reword patch for dell-laptop
> 
> Armin Wolf (3):
>   ACPI: battery: Simplify battery hook locking
>   ACPI: battery: Fix possible crash when unregistering a battery hook
>   platform/x86: dell-laptop: Do not fail when encountering unsupported
>     batteries
> 
>  drivers/acpi/battery.c                  | 27 ++++++++++++++++---------
>  drivers/platform/x86/dell/dell-laptop.c | 15 +++++++++++---
>  include/acpi/battery.h                  |  1 +
>  3 files changed, 31 insertions(+), 12 deletions(-)
> 
> --
> 2.39.5
> 



-- 
I'm available for contract & employment work, please contact me if
interested.


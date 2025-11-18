Return-Path: <linux-acpi+bounces-19040-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E41C6BE7F
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 23:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id BD8FB2BDFB
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 22:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E1309F0A;
	Tue, 18 Nov 2025 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svZ7gpGL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0992D8372;
	Tue, 18 Nov 2025 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763506513; cv=none; b=jfFQ5sgAG84Li5wUQwAk8bisCFnEUaTfgGB+YeBszC0VnbCPwY45qr3xf2ZV8lKzxPMjD8E8+NvixjdKiQCAgw4fXF41N8lOUt7im1L3ZbfJ8qINIYMrLFdaevqR+la3G9VxpXhL1fYTcZ0zr49sgXTsC9W5v1uxzk2iW8eNDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763506513; c=relaxed/simple;
	bh=ECVRPnw3Dhpq/9Py1ARDE4+WGX1Y5233CDDNwtbgC2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EijmAVWGzjtPXWmFay+jcRS2RF7P3ihVaqrXBxjTgFD/Lfj+hZLn2vWTlIoJPvNBAusXdkcZAR6wyD50v0QMFC/U4qPcxsPQ4Szqj2faoCid4OU57MOEvoHfIQyWkD6qg6Xqa6umFM9iqdlpQxuF/G4T9pMlCYV6suUy3n2GTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svZ7gpGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6426EC19425;
	Tue, 18 Nov 2025 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763506511;
	bh=ECVRPnw3Dhpq/9Py1ARDE4+WGX1Y5233CDDNwtbgC2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svZ7gpGLXJyX4ewPplNwWJkALIe4g/9+nzUE8VUkPwZdgaYr5lRvzcfe7kaUPIjBS
	 4JZeuPH0pc1X2t9dl2nMGlWU3mI/oATcnOj0cHPwmpJX3GGiG5dD4xsMUiVDcd9Hqw
	 312jzLTzMoU/a8k50zucWfTuCcmbrmggU1p35wFAYUHZMtjhFXStNjOzR3LFZIqve4
	 Rdlcp5Qv4F81QWxFOtox33m80qTNMoFklv//0ag/RTuEiQKkmn6aABms8c5021usEc
	 pBBF9MYjHfN9a8LmgCmhX6xqPnhMl/wpOQdKcZirQ5YHKDwFZfLIZBi6nek4KKsqkK
	 hhyQ0PImEWlyA==
Date: Tue, 18 Nov 2025 14:55:07 -0800
From: Drew Fustini <fustini@kernel.org>
To: Ben Horgan <ben.horgan@arm.com>
Cc: james.morse@arm.com, amitsinght@marvell.com, baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com, catalin.marinas@arm.com,
	dakr@kernel.org, dave.martin@arm.com, david@redhat.com,
	dfustini@baylibre.com, fenghuay@nvidia.com,
	gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
	jeremy.linton@arm.com, jonathan.cameron@huawei.com,
	kobak@nvidia.com, lcherian@marvell.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
	peternewman@google.com, quic_jiles@quicinc.com, rafael@kernel.org,
	robh@kernel.org, rohit.mathew@arm.com, scott@os.amperecomputing.com,
	sdonthineni@nvidia.com, sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
Subject: Re: [PATCH 00/33] arm_mpam: Add basic mpam driver
Message-ID: <aRz5S/gnT9mhqN+7@x1>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <aRoG+UptQg9mix+7@x1>
 <753f4d26-efa9-4ffd-a820-7c2a53c0bc5f@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <753f4d26-efa9-4ffd-a820-7c2a53c0bc5f@arm.com>

On Tue, Nov 18, 2025 at 02:11:31PM +0000, Ben Horgan wrote:
> Hi Drew,
> 
> On 11/16/25 17:16, Drew Fustini wrote:
> > On Fri, Nov 07, 2025 at 12:34:17PM +0000, Ben Horgan wrote:
> >> Hi all,
> > [snip]
> >> The rest of the driver can be found here: (no updated version - based on v3)
> >> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc1
> > 
> > Does anyone know of a hosting platform that offers ARM machines that
> > have MPAM?
> 
> As far as I know there aren't any.
> 
> There is some MPAM support in the Orion Radxa board which is likely the
> cheapest option. The MPAM acpi table isn't in the firmware though so
> you'd need to load a custom table. James has this working.

Thank you, I didn't realize that there was a dev board that supports
MPAM. I didn't want to the expense or noise of a rackable server :)

Drew


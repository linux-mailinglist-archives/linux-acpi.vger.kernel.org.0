Return-Path: <linux-acpi+bounces-18923-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0230AC61951
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Nov 2025 18:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1B8C3539B5
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Nov 2025 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97B2F99AA;
	Sun, 16 Nov 2025 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHtRDR2y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A141946DF;
	Sun, 16 Nov 2025 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313404; cv=none; b=EtcJgltanYydG6NjnJO836PK6Cidy8nJ8nlVpRrmfs8aDqdwJLfPlhpdW7oEBmdYUkukWhWSa734KRPGHCTg2bEDBPQbpgMdwz9hPXi+VlT80ITdO16qiltMZ4eO3/8KKfAXJdq/OnIZnRwGrNccYMCLK+mjkcTbOGXnfFma664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313404; c=relaxed/simple;
	bh=VzP7wxhTeAxzhdg8HhtFXlTCOKKv3JTHOUYVOcZdWGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZjNMuExkwTO1SxZeBbYDzRhU0XRk8nKfUYajMAzqw5A5lS2ay0d+LP9KyUgMaTt/dYAA2JY9rSSN1EsDez5/a1XO2aMeOh5ddftutZjc+/Aw9M7CXgqFO3AZvrqiLjhWdCjXiqe+pWQ/NGGHDDv3rUl3M70d8mryzvR+GID0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHtRDR2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D668C116B1;
	Sun, 16 Nov 2025 17:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763313403;
	bh=VzP7wxhTeAxzhdg8HhtFXlTCOKKv3JTHOUYVOcZdWGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHtRDR2y0eMCYeVh6K5xl1YDcW0uGrybT2sGMwQB7JGTyJa3QW/bzPLTh0WYWAU83
	 FgGvxGFcr5oIhccUAy4DlBI8VLRVxCITyFuFXo9GK1X/YTgDii0G44RhnJQkZ5On7G
	 Ygle6K0IHqruF9HhGS7VM0GyeGhyX+J904pET7Uxe4hF94TcWnHRto4ugA4+8RO4Ca
	 lDrtuJn1xLJPKOKOiEdfI1838p7m+osWaKc3zQ3xUuVw6avLdLgcXQ/aHQ9SOofHRP
	 wHT9RpxZ5RhtUX6nyd1Aoop7neGlOsfahE8o5sekc5f5L8zqjCNtEBfQewjJ3q5F5C
	 VQ72U//e5tYww==
Date: Sun, 16 Nov 2025 09:16:41 -0800
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
Message-ID: <aRoG+UptQg9mix+7@x1>
References: <20251107123450.664001-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107123450.664001-1-ben.horgan@arm.com>

On Fri, Nov 07, 2025 at 12:34:17PM +0000, Ben Horgan wrote:
> Hi all,
[snip]
> The rest of the driver can be found here: (no updated version - based on v3)
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc1

Does anyone know of a hosting platform that offers ARM machines that
have MPAM?

I see there are Ampere systems on Oracle but I wasn't sure if those have
MPAM.

I'm getting a RISC-V QoS patch series ready (Ssqosid ext and CBQRI spec)
and I'd like to get a better understanding of how resctrl works on MPAM
in practice.

Thanks,
Drew


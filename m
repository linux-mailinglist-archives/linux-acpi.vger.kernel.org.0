Return-Path: <linux-acpi+bounces-16416-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67BFB45DAB
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 18:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1BA16278A
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA852FB0AF;
	Fri,  5 Sep 2025 16:13:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC92F49E9;
	Fri,  5 Sep 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088830; cv=none; b=TXGFTHjrFLY7TdemhZpyTlt8ePr99c7uxWE7PX2xYdfBlSykJHUqKQOtk7y7SN5KJ3fDl7fE1ezRx4hZUi6h3yNXhKVefghd3JkOqkDwgsgBlYAYVT8Ka8ZXioXNLFkH6HBCef5z21aYxH4SYbrTcUATLyQ3pmArzBjPpbqkQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088830; c=relaxed/simple;
	bh=7LYt8wC/dkDb1seY5kd6KKYJfmiholW07fGWmChvZDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqoYxeYmNFUIm6AjuO2x9vuhcTPTjzUzpDLHPhB41vZDGCojSmOD5G/JizMHaI7MdpzdXm1c7gpTByZnTlZ1yEfIzFEQKgsMm4bfPMcHcBKzS8/7QTuG9O1sA+shh8s72+6HnUJ1DRi+NVI6Fi/1g1ZsaGnL0KF1W/GeXDO1lMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71ACC4CEF1;
	Fri,  5 Sep 2025 16:13:46 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Joerg Roedel <jroedel@suse.de>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Miaoqian Lin <linmq006@gmail.com>
Cc: Will Deacon <will@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ACPI/IORT: Fix memory leak in iort_rmr_alloc_sids()
Date: Fri,  5 Sep 2025 17:13:38 +0100
Message-ID: <175708881848.3546185.8093132917549688443.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250828112243.61460-1-linmq006@gmail.com>
References: <20250828112243.61460-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 28 Aug 2025 19:22:43 +0800, Miaoqian Lin wrote:
> If krealloc_array() fails in iort_rmr_alloc_sids(), the function returns
> NULL but does not free the original 'sids' allocation. This results in a
> memory leak since the caller overwrites the original pointer with the
> NULL return value.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] ACPI/IORT: Fix memory leak in iort_rmr_alloc_sids()
      https://git.kernel.org/arm64/c/f3ef7110924b

-- 
Catalin



Return-Path: <linux-acpi+bounces-1831-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25EB7F9BBA
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 09:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689371F201A1
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095B12E50
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Nov 2023 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3302B138;
	Sun, 26 Nov 2023 23:22:44 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6A01D68AFE; Mon, 27 Nov 2023 08:22:40 +0100 (CET)
Date: Mon, 27 Nov 2023 08:22:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, rafael@kernel.org, lenb@kernel.org, robh+dt@kernel.org,
	frowand.list@gmail.com, m.szyprowski@samsung.com,
	james.quinlan@broadcom.com, iommu@lists.linux.dev,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Don't store redundant offsets
Message-ID: <20231127072240.GA28430@lst.de>
References: <94e0cec15546ef2be61d90869e499e40e2a55308.1700849106.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e0cec15546ef2be61d90869e499e40e2a55308.1700849106.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 24, 2023 at 06:10:03PM +0000, Robin Murphy wrote:
> A bus_dma_region necessarily stores both CPU and DMA base addresses for
> a range, so there's no need to also store the difference between them.

Yes.  I'll add this to the for-next branch for 6.8 once I open it.



Return-Path: <linux-acpi+bounces-6053-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF2E8D18F7
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 12:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5053C1C22EE5
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CFC16B756;
	Tue, 28 May 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3FJG2i6r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A1813C8F9;
	Tue, 28 May 2024 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893640; cv=none; b=B/bNXIAkEdKkiaU7I0hU9LsFukBWt3G290TC4zvMYQayiRms22qMzFdKskJ+mlJL8shkcOEyOrosx33uBCRWILMl28LWFI8V4kOdWZiyajEyas9YNf7Ntzctuf43i3a8A3+7NEWRi7GOgU/BDksB70PyYW9lG9wRffCjiDwqmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893640; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCXpZdJ8tjdCHKBXmOr6cP8kCRP5unM+gHp+mVUzTKzIpIGUWTiemNZX47789lVBn1LidAefpUPyQD+ROFP+uXq58XonmHlPiVqutmLA8FImOLxT0AByj84DGUkr/WY0KLdkaZ/HZCAu8w5k9lDlqxZEzfq0dpG/lsHUMQbzmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3FJG2i6r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3FJG2i6r9h5Z0dprs47K4InJYM
	ymbJhmRc0PDeRRdQQ8qIvzYLDttRNprlu48P6lycPlrsrk/KH1Kqa/ba99/GUQrKc7CLu7CObSvaE
	VfxWSHXqRDblTOuvyTod/EX4fG3On3u32ePhAYfkP5HTLayy0Tu0/v6pb5dnyEy+UHmwnvVH+OGZo
	6n6v0HTH7Ceim90cZq88BNAMx5mWOOYaGqLj6gxkRtW4Kk8uDqZowARTHmZjcK4uF8a/0L7m5b8uN
	yIJJobyFeyqCPV6msc5JBEKMhQjlO69DHZZLAlUMcBB63WxAyHVVMEZgMfvFTPs8VeGWfqMc4JpKV
	TZNMShBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBuSo-00000000HBL-2x3D;
	Tue, 28 May 2024 10:53:54 +0000
Date: Tue, 28 May 2024 03:53:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Guanbing Huang <albanhuang@outlook.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/2] PNP: Hide pnp_bus_type from the non-PNP code
Message-ID: <ZlW3wpR0wa9Hqa4a@infradead.org>
References: <20240528102708.1451343-1-andy.shevchenko@gmail.com>
 <20240528102708.1451343-3-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528102708.1451343-3-andy.shevchenko@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


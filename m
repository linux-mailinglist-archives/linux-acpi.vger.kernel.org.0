Return-Path: <linux-acpi+bounces-17223-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3A5B955BD
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 12:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B96188661F
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7896F1946DF;
	Tue, 23 Sep 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjNHRCyo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E5018027;
	Tue, 23 Sep 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621623; cv=none; b=tM9lD9Fowejt6NVtU4oLSrC8K5V7lRQ+m2gASPM0shERYTjtYYWVX3Wk4Ty1J9dBePPDlydznNfBE7Slu8WKRasPMop7g41+eCMgeUMmfNzU+SFPOcKM16ZVdvn75BNIVkXLKT1pT8M37IgF1Pnqeu2s5OhNFkshmbI3j39rSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621623; c=relaxed/simple;
	bh=ZmLDLSUhIgyW2E8XpVDH7PtXAL41rLjhjSwjbacf3Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4lnoi9Mqx8CfrJMaP12RDr9e8N3JE4kXe2qQ31PT0eq7ICwppQTC03wCz4UuXUXqyStIqi44reH+iAuxGZT8Vw3orvrSHBtBFoEFMoxpsPYWcCZcrzb6CGXu10jASLbJLuA9R5X+eoY9Nu6eKjKNWVTWLc9OY/f8+mmbcOtnec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjNHRCyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E520C4CEF5;
	Tue, 23 Sep 2025 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758621622;
	bh=ZmLDLSUhIgyW2E8XpVDH7PtXAL41rLjhjSwjbacf3Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjNHRCyoSIySI2JhgkojZyWPyLtiZig84JvxQ9PEE0iM67VwKEdkxgjrz7Sl+LLTA
	 oNbfPYeLB/6BqR03oGyAlFOH5iTo3mngIYeR6I3Wcl1O3m8ZX5Jt99G0GOXCaA/lZa
	 IA+9u5g6CggSnHPVLE77lZXdPpsEf8RKY8tkiF537g1CcQNhN//sk5kmD643Rb5ouQ
	 pFL1yRhqCWOOeYRpt+174zdvVW+SenPm+0C5FrxfnJGC6JS0UmUlf6tH8V2tVXZvDe
	 gHgZ9GjdWr8a8pePNZSPrAuKti1KPLl84otJjeXKoRT/6XMjwrKunapbB0cx5X70+V
	 7VzrsPInmPLng==
Date: Tue, 23 Sep 2025 11:00:16 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v3 00/26] genirq: Add support for percpu_devid IRQ
 affinity
Message-ID: <aNJvsJOZHD87WTx4@willie-the-truck>
References: <20250922082833.2038905-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922082833.2038905-1-maz@kernel.org>

Hi Marc,

On Mon, Sep 22, 2025 at 09:28:07AM +0100, Marc Zyngier wrote:
> This is the third version of this series, originally posted at [1],
> which aims at allowing percpu_devid interrupt requests on the basis of
> an affinity mask. See the original submission for the details of why
> this is a desirable outcome.

FWIW, I backported this to 6.12 and tested it on a DT-based Android
device with heterogeneous PMUs and pNMI enabled. Perf appears to work
correctly, the pNMIs are configured as expected and the affinities
all look good to me.

Tested-by: Will Deacon <will@kernel.org>

Will


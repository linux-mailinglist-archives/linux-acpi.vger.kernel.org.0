Return-Path: <linux-acpi+bounces-936-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D97D5A98
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 20:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D1E280F0C
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5003CCE3
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXMNYUnA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CAA2420F
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 17:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FCAC433C7;
	Tue, 24 Oct 2023 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698168822;
	bh=cRNvW+OGH4FZW5C10ppvR2jaVa3oMkeSWjybFPNXAIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXMNYUnAZaFjGuDJ2uNnMycMphCRDmkHACSKrVTdKnE9FhJezZCfvsTDA+sRXmNbW
	 6J6j8sYtnLm+hR5wEYzDimuDBk6yu29G8iiO8T7Y6ixa3pkgKoOSlyzOwbD6xrrIFW
	 tNghN/GJkGOlGTo8u95dy1XPyg4iCreQbeQd/RuK8LnQn9ChowR7Oz5GcLWBzaYB7Z
	 wPfi4/vfJr7Ota/3YfvCC1jGHiKEvJTtFSxf0iBTK6iK3mSHbLSCxHRMyQsbBLLPED
	 BrkRQ6NdW5CmgbCjLoMsFkYF8BKmtUp74ZjIVS5nrRhJ8JgSSJwpf7GGgzjMZ4s4B1
	 nJimsps1YC7DA==
Date: Tue, 24 Oct 2023 19:33:38 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	linux-acpi@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH 1/2] ACPI: Add helper acpi_use_parent_companion
Message-ID: <20231024173338.haei2py7izlqxjmw@zenone.zhora.eu>
References: <90bd1071-317e-4dfe-b94b-9bcee15d66c5@gmail.com>
 <6e935761-5b36-411a-ac82-cbc394bba7b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e935761-5b36-411a-ac82-cbc394bba7b6@gmail.com>

Hi Heiner,

On Sun, Oct 15, 2023 at 11:34:25PM +0200, Heiner Kallweit wrote:
> In several drivers devices use the ACPI companion of the parent.
> Add a helper for this use case to avoid code duplication.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Wolfram, can we take this in i2c? Otherwise this will take two
release rounds to get in.

Andi


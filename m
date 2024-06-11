Return-Path: <linux-acpi+bounces-6295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC039032AF
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 08:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25CA1C25412
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 06:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA217167D;
	Tue, 11 Jun 2024 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT+LPql6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23B171647;
	Tue, 11 Jun 2024 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087563; cv=none; b=SCLos/GoGx1uufKcWmlqNC9pl+cLnP0K92HJugBxJdyF/KZgSc74pU0j3NP8tvReYbwr4HCYpv4MqvqghiL2g1h4ypyxfCm2w1NkOGC+YjyGIOfTZ1FhFrxYSaiXhEAm5ECh5FLpLRC/dglRWOB0jBqRcISu8dOv8FwP5pdMDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087563; c=relaxed/simple;
	bh=27itxGlfcgEv3PcvLTnBGYHx7ycnbMROORcs9t+26e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONoOcPqVy/KRxlenX+wcIzyaKtzJ9L9DwGeujdJd9sAS9TSZOqzmSdZ03kV63EkmJoKFYDiQ/ORaqVAGlV3jLwGK5EBFeFBVNX8xaV3FC8M/OpWo4T/NS0NB+IH0jl5t9OgnekBxcBViO3FJrqojTWTY/nbB6gFpywzCHHqnSAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT+LPql6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC46C2BD10;
	Tue, 11 Jun 2024 06:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718087563;
	bh=27itxGlfcgEv3PcvLTnBGYHx7ycnbMROORcs9t+26e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OT+LPql6ztvY/rQD/i6nhXnOBYdJBmRK1RgXYIRal1yV4AJA1fyxVQ3f9iqqu8JI+
	 Ffsl1ygNdFWNixrIwhRLVe1exWzu9bW8A2L/BK8vjdnnw20E5C6Etl0LybemHp+9dF
	 RIh3/4SnTbBuThPc5M6PsI0jOJQsyNRqgHMyE+eqrw6kiZINZ9aGu4g8/awUHKMBn1
	 mCxMMA5mtC0+P6kfWKJkQt/NaaA+CQHhUkavWU0TvsL/QcjJefbH/NhYqCkWdeJe/I
	 Ho7l9OIwaGPpm3PaV87BtbfVTTYMK0Z8mJiQhISOCU4K7kAlGBGTWvZ3D3WF1rGifR
	 44n1MHb6l1qtQ==
Date: Tue, 11 Jun 2024 06:32:38 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dustin Howett <dustin@howett.net>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Rajas Paranjpe <paranjperajas@gmail.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Matt Hartley <matt.hartley@gmail.com>
Subject: Re: [PATCH v3 3/5] platform/chrome: cros_ec_proto: Introduce
 cros_ec_cmd_versions()
Message-ID: <ZmfvhvcjTbjOSp4f@google.com>
References: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
 <20240610-cros_ec-charge-control-v3-3-135e37252094@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610-cros_ec-charge-control-v3-3-135e37252094@weissschuh.net>

On Mon, Jun 10, 2024 at 05:51:08PM +0200, Thomas Weißschuh wrote:
> If the command is not supported at all the EC returns
> -EINVAL/EC_RES_INVALID_PARAMS.
> 
> This error is translated into an empty version mask as that is easier to
> handle for callers and they don't need to know about the error details.

I'm not sure whether the behavior is what we want or not as existing
EC_CMD_GET_CMD_VERSIONS usages don't have it.


Return-Path: <linux-acpi+bounces-6313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE94C9048F9
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 04:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6489E28AA8A
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 02:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037368C1E;
	Wed, 12 Jun 2024 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZFbygVd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F49A34;
	Wed, 12 Jun 2024 02:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159142; cv=none; b=NYXpio76fhZLmfQhS/jqXIqjCjj5r1ttVjqSjyoBJS8GtxNNHVC732t9r3g0Kf0aY+POdf8IgjUQCB6O/nyMi8oCyL2ye+oQb77o34O5u6gVdhi0uoOyVlCkr6nHdB22eBrm6fLImctm2D5FTVvq7q+NYgnDR1YbyNjARcjgoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159142; c=relaxed/simple;
	bh=ge6+rdG4NL/1L70rAxfH+r2Izoc6INz7bqA0W1h52BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAWy2WJWz6BupZQtaTfuOmBMJOjZtZM0/6kB2GJ0ZQfhFXVl9lz74SzrzOr7aw+vTa2wWx7z++gpDchRU8NGU6F6M4fOu+AKcLpU64I2+SlR3SPn7qDoiy7/Oeg3MQA7+5I7MNTeDmHofuSPPDAd/VKMHNgRlFFrFpxeb69mukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZFbygVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65A8C2BD10;
	Wed, 12 Jun 2024 02:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718159142;
	bh=ge6+rdG4NL/1L70rAxfH+r2Izoc6INz7bqA0W1h52BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZFbygVdOyelHVyIZFVWoqPHnCs2Fc8gpVLwM15UtC294nSvYisXaKpW3siCBECZ6
	 riO98Iz6I17HIM+Iu7lVnxRX8x//8faAFuLAX8VuX4+49S5LfEP07w7kRyQEOONXBS
	 lQdKhIgz8HkWkE92r437LVea+h63FDEU68jRw7SlpDOSMHfyx8/vy3sqR8JzQ4EhWS
	 H/POONZFHNqpxWgqf61O4u9lNZL+AV7D9ja8GCYbt9h//MXOffrhj5D+uu19ruM+gy
	 PUGV/KpdTDEz2i2ltuTfBSSA2m/n1oWDzJAQw6cxDPaKFqE5qQ1zcfSsmwO2ir4T5z
	 Rt2gTB4Rs6avQ==
Date: Wed, 12 Jun 2024 02:25:37 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>,
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
Message-ID: <ZmkHIeMCYpcxCC6l@google.com>
References: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
 <20240610-cros_ec-charge-control-v3-3-135e37252094@weissschuh.net>
 <Zmg2iwOWRZdCybxw@google.com>
 <96f0d632-7fdd-4fca-9528-449440d72f5d@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96f0d632-7fdd-4fca-9528-449440d72f5d@t-8ch.de>

On Tue, Jun 11, 2024 at 02:14:33PM +0200, Thomas Weißschuh wrote:
> On 2024-06-11 11:35:39+0000, Tzung-Bi Shih wrote:
> > On Mon, Jun 10, 2024 at 05:51:08PM +0200, Thomas Weißschuh wrote:
> > > + *
> > > + * @ec_dev: EC device
> > > + * @cmd: Command to test
> > > + *
> > > + * Return: version mask on success, negative error number on failure.
> > > + */
> > > +int cros_ec_cmd_versions(struct cros_ec_device *ec_dev, u16 cmd)
> > 
> > Could it support a "version" parameter as existing EC_CMD_GET_CMD_VERSIONS
> > usages use both versions?  An `u16 cmd` parameter and down-cast to u8 for v0
> > should be fine. (ec_params_get_cmd_versions vs. ec_params_get_cmd_versions_v1)
> 
> Ack.
> 
> Or we could automatically use v0 if cmd <= U8_MAX?

Ack.  Looks feasible.


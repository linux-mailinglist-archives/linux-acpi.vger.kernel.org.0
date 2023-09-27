Return-Path: <linux-acpi+bounces-216-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CB67B0A26
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id A8392B209ED
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AFD7476
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:31:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4411846
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:47:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4A38F4;
	Wed, 27 Sep 2023 07:47:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACA521FB;
	Wed, 27 Sep 2023 07:47:53 -0700 (PDT)
Received: from bogus (unknown [10.57.37.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3CFA3F59C;
	Wed, 27 Sep 2023 07:47:13 -0700 (PDT)
Date: Wed, 27 Sep 2023 15:45:52 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/3] ACPI: PCC: Define and use the common PCC shared
 memory regions related macros
Message-ID: <20230927144552.pqolbw5p22sgc22l@bogus>
References: <20230926-pcc_defines-v1-0-0f925a1658fd@arm.com>
 <CAJZ5v0hq37x_v6Z0Vqj2h8D5QZM8zWE4=GfrMk7YAEfUjeRydA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hq37x_v6Z0Vqj2h8D5QZM8zWE4=GfrMk7YAEfUjeRydA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 04:19:21PM +0200, Rafael J. Wysocki wrote:
> On Tue, Sep 26, 2023 at 2:33 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > This set of 3 small patches intend to consolidate and replace the existing
> > locally defined macros within couple of PCC client drivers when accessing
> > the command and status bitfields.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> > Sudeep Holla (3):
> >       ACPI: PCC: Add PCC shared memory region command and status bitfields
> >       i2c: xgene-slimpro: Migrate to use generic PCC shmem related macros
> >       hwmon: (xgene) Migrate to use generic PCC shmem related macros
> >
> >  drivers/hwmon/xgene-hwmon.c            | 16 +++++-----------
> >  drivers/i2c/busses/i2c-xgene-slimpro.c | 16 ++++------------
> >  include/acpi/pcc.h                     | 11 +++++++++++
> >  3 files changed, 20 insertions(+), 23 deletions(-)
> > ---
> 
> This is fine with me.
> 
> How do you want to route it?

I have to respin this to include another driver.

I also have 2 PCC mailbox driver changes that I wanted to send a pull request
to you. I can make this part of that PR or you can take it directly. Both
hwmon and i2c maintainers have acked now.

--
Regards,
Sudeep


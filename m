Return-Path: <linux-acpi+bounces-287-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF2A7B3295
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 14:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4A63C1C2099A
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C7B19458
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 12:31:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8818021
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 11:45:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4B1C1980;
	Fri, 29 Sep 2023 04:45:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D77501FB;
	Fri, 29 Sep 2023 04:45:53 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 29B803F59C;
	Fri, 29 Sep 2023 04:45:14 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v2 0/4] ACPI: PCC: Define and use the common PCC shared memory regions related macros
Date: Fri, 29 Sep 2023 12:45:10 +0100
Message-ID: <169598703811.2113895.1673081540867422060.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927-pcc_defines-v2-0-0b8ffeaef2e5@arm.com>
References: <20230927-pcc_defines-v2-0-0b8ffeaef2e5@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 27 Sep 2023 17:26:09 +0100, Sudeep Holla wrote:
> This set of 3 small patches intend to consolidate and replace the existing
> locally defined macros within couple of PCC client drivers when accessing
> the command and status bitfields.
>

Applied to sudeep.holla/linux (for-next/pcc/updates), thanks!

[1/4] ACPI: PCC: Add PCC shared memory region command and status bitfields
      [fixed the signature value]
      https://git.kernel.org/sudeep.holla/c/55d235ebb684
[2/4] i2c: xgene-slimpro: Migrate to use generic PCC shmem related macros
      https://git.kernel.org/sudeep.holla/c/89a4ad1f437c
[3/4] hwmon: (xgene) Migrate to use generic PCC shmem related macros
      https://git.kernel.org/sudeep.holla/c/2cf39b806be7
[4/4] soc: kunpeng_hccs: Migrate to use generic PCC shmem related macros
      https://git.kernel.org/sudeep.holla/c/a46e42c09798
--
Regards,
Sudeep



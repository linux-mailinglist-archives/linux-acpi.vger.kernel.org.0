Return-Path: <linux-acpi+bounces-202-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0D47B06F0
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E7BA128262F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15E3B282
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:33:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71D37CAC
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:01:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FBBBFC;
	Wed, 27 Sep 2023 07:01:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E7151042;
	Wed, 27 Sep 2023 07:02:22 -0700 (PDT)
Received: from bogus (unknown [10.57.37.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E03B3F59C;
	Wed, 27 Sep 2023 07:01:42 -0700 (PDT)
Date: Wed, 27 Sep 2023 15:00:22 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/3] ACPI: PCC: Define and use the common PCC shared
 memory regions related macros
Message-ID: <20230927140022.qeck6t7mbnq7ky7s@bogus>
References: <20230926-pcc_defines-v1-0-0f925a1658fd@arm.com>
 <9497cf31-09b9-b083-bbe8-84307178b20a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9497cf31-09b9-b083-bbe8-84307178b20a@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 10:11:21AM +0800, lihuisong (C) wrote:
> Hi Sudeep,
> 
> Could you please use these new common macros for kunpeng_hccs?

Sure, sorry for missing that. I had these changes in a branch for a while,
did check for new additions when I decided to post them.

-- 
Regards,
Sudeep


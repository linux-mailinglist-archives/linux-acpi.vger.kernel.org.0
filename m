Return-Path: <linux-acpi+bounces-31-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B8D7A9C67
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 21:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708BBB231B3
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450AE59835
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 18:43:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC913F4CB
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 18:10:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9165BAF96F;
	Thu, 21 Sep 2023 11:07:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20914169C;
	Thu, 21 Sep 2023 06:52:55 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FCB33F59C;
	Thu, 21 Sep 2023 06:52:16 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: rafael@kernel.org,
	rafael.j.wysocki@intel.com,
	robbiek@xsightlabs.com,
	guohanjun@huawei.com,
	Huisong Li <lihuisong@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wanghuiqiang@huawei.com,
	zhangzekun11@huawei.com,
	wangxiongfeng2@huawei.com,
	tanxiaofei@huawei.com,
	wangkefeng.wang@huawei.com,
	liuyonglong@huawei.com
Subject: Re: [PATCH RESEND v4 0/2] mailbox: pcc: Support platform notification for type4 and shared interrupt
Date: Thu, 21 Sep 2023 14:52:13 +0100
Message-ID: <169530429882.3222950.12070743250083833774.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230801063827.25336-1-lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com> <20230801063827.25336-1-lihuisong@huawei.com>
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

On Tue, 01 Aug 2023 14:38:25 +0800, Huisong Li wrote:
> PCC supports processing platform notification for slave subspaces and
> shared interrupt for multiple subspaces.
> 

Applied to sudeep.holla/linux (for-next/pcc/updates), thanks!

[1/2] mailbox: pcc: Add support for platform notification handling
      https://git.kernel.org/sudeep.holla/c/60c40b06fa68
[2/2] mailbox: pcc: Support shared interrupt for multiple subspaces
      https://git.kernel.org/sudeep.holla/c/3db174e478cb
--
Regards,
Sudeep



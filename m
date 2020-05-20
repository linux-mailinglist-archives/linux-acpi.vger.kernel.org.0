Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7301DBC09
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 19:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgETRyv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 13:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgETRyt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 13:54:49 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6973E20823;
        Wed, 20 May 2020 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589997288;
        bh=tSusfwEtnTufQiTMMaZ15xY6HANjfc5RrrUfXAHd4bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WzowI8+GqPbs73hL8wdgdaas6aoLB4lvYGw1rWSCDNTR9IC7pFclCVbjgGMKgBAh5
         uB8VqgZAdfEHAyY7/qcBGKGpkHNPWQ1Y/ve3p3PeYIQ8Vv10LRnYd9/A8NnP+uNj10
         z/N/0AOm7CzIOSU+1BrQmu7FJsG6OoT+c8Inlxnk=
From:   Will Deacon <will@kernel.org>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        patches@amperecomputing.com, Robin Murphy <robin.murphy@arm.com>,
        Len Brown <lenb@kernel.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5] ACPI/IORT: Fix PMCG node single ID mapping handling
Date:   Wed, 20 May 2020 18:54:38 +0100
Message-Id: <158999660879.126681.3746296394205258449.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1589994787-28637-1-git-send-email-tuanphan@os.amperecomputing.com>
References: <1589994787-28637-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 20 May 2020 10:13:07 -0700, Tuan Phan wrote:
> An IORT PMCG node can have no ID mapping if its overflow interrupt is
> wire based therefore the code that parses the PMCG node can not assume
> the node will always have a single mapping present at index 0.
> 
> Fix iort_get_id_mapping_index() by checking for an overflow interrupt
> and mapping count.
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI/IORT: Fix PMCG node single ID mapping handling
      https://git.kernel.org/arm64/c/50c8ab8d9fbf

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

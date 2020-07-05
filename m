Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F99214F69
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Jul 2020 22:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgGEUjA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Jul 2020 16:39:00 -0400
Received: from ms.lwn.net ([45.79.88.28]:51734 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbgGEUi7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 5 Jul 2020 16:38:59 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 21ADE823;
        Sun,  5 Jul 2020 20:38:59 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:38:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 0/3] Documentation: arm64: eliminate duplicated words
Message-ID: <20200705143858.4cd8491e@lwn.net>
In-Reply-To: <20200703205110.29873-1-rdunlap@infradead.org>
References: <20200703205110.29873-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri,  3 Jul 2020 13:51:07 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Drop doubled words in Documentation/arm64/.
> 
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> 
>  Documentation/arm64/acpi_object_usage.rst |    2 +-
>  Documentation/arm64/arm-acpi.rst          |    2 +-
>  Documentation/arm64/sve.rst               |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

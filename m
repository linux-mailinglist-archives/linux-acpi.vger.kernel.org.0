Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255D7214077
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jul 2020 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgGCUvX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Jul 2020 16:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgGCUvX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jul 2020 16:51:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A06C061794;
        Fri,  3 Jul 2020 13:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9vglfDNb8sJvxMdBu5yH0RgAYAdcTUlgWbZL6Tj+A58=; b=A52+28EypBEZGuTr7BP7GqEsyl
        tWOvIpH4YqJ2Orzr9AyvRhaGaiFwmeDK76FvJLi97P/3NSbraERU7QttmCB//ksQlRPHZxqLzK+eY
        HlvfsnszrcoxKJJwzQFOjys9QDNM6PiNv9K0rGKlqBwhXot7byBPIvcYizHFwWftv/ICSURzKQYjD
        V8EcFQY4l7jN1JC8Da7v4vk/425QDmvcKgN2XijhaXVIWnYYKOAU5j1pLqNaU3YB2YMapwwIKMuXk
        Z6L7h8iCvCHxZkFf0TXQaLI8AHU47Y9S9vBVQk++9htorQyKc0B7sqqEARuMSZpo+yvM0joIM0O8o
        S7b6347Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrSeT-0001yn-JD; Fri, 03 Jul 2020 20:51:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 0/3] Documentation: arm64: eliminate duplicated words
Date:   Fri,  3 Jul 2020 13:51:07 -0700
Message-Id: <20200703205110.29873-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Drop doubled words in Documentation/arm64/.


Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>

 Documentation/arm64/acpi_object_usage.rst |    2 +-
 Documentation/arm64/arm-acpi.rst          |    2 +-
 Documentation/arm64/sve.rst               |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

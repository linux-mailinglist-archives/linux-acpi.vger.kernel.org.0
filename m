Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E72536D4F9
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhD1JtT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 05:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238277AbhD1JtT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Apr 2021 05:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619603314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y04zd6fW1Eb2Q5W4r93j3/pSOFEh/Z5A0rPT+2bNFSY=;
        b=Xv0HyLBxMjzT6AaF7iVKGATVRo48nmM79J/Ay3OhdnUN2NqHMvdog+iMJQ/WcZMP9sO+rQ
        7+O0ryiyjqRbdqcB2CjaTyxtRe9ozb/QMwxSuXAfn86Tmxdy+aXG3Eml2ZRwqhB6MXieO5
        +ZVHSG8/sJjIMF1uEypYkZGdnYqWQkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-yB9gVyDBOFGTyjPHqPgZFQ-1; Wed, 28 Apr 2021 05:48:29 -0400
X-MC-Unique: yB9gVyDBOFGTyjPHqPgZFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80B2B803620;
        Wed, 28 Apr 2021 09:48:25 +0000 (UTC)
Received: from gator.redhat.com (unknown [10.40.192.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2D4D5D6D5;
        Wed, 28 Apr 2021 09:48:12 +0000 (UTC)
From:   Andrew Jones <drjones@redhat.com>
To:     song.bao.hua@hisilicon.com
Cc:     aubrey.li@linux.intel.com, bp@alien8.de, bsegall@google.com,
        catalin.marinas@arm.com, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, guodong.xu@linaro.org, hpa@zytor.com,
        jonathan.cameron@huawei.com, juri.lelli@redhat.com,
        lenb@kernel.org, liguozhu@hisilicon.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org,
        mark.rutland@arm.com, mgorman@suse.de, mingo@redhat.com,
        msys.mizuma@gmail.com, peterz@infradead.org,
        prime.zeng@hisilicon.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        sudeep.holla@arm.com, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, will@kernel.org, x86@kernel.org,
        xuwei5@huawei.com, yangyicong@huawei.com
Subject: Re: [RFC PATCH v6 1/4] topology: Represent clusters of CPUs within a die
Date:   Wed, 28 Apr 2021 11:48:11 +0200
Message-Id: <20210428094811.159245-1-drjones@redhat.com>
In-Reply-To: <20210420001844.9116-2-song.bao.hua@hisilicon.com>
References: <20210420001844.9116-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 20/04/2021 12:18, Barry Song wrote:
...
> Currently the ID provided is the offset of the Processor
> Hierarchy Nodes Structure within PPTT.  Whilst this is unique
> it is not terribly elegant so alternative suggestions welcome.
> 

The ACPI table offsets are consistent with how other topology IDs are
generated. I once tried to make them a little more human friendly with
[1], but it was nacked.

[1] https://lore.kernel.org/lkml/20180629132934.GA16282@e107155-lin/t/

Thanks,
drew


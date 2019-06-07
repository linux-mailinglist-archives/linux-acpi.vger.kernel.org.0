Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A70238769
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2019 11:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfFGJwm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Jun 2019 05:52:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42886 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbfFGJwm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 Jun 2019 05:52:42 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AC461D2F7002C7D59082;
        Fri,  7 Jun 2019 17:52:39 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 7 Jun 2019
 17:52:28 +0800
Date:   Fri, 7 Jun 2019 10:52:20 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [RFC] NUMA Description Under ACPI 6.3 White Paper (v0.93)
Message-ID: <20190607105220.0000134e@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

This is a request for comment / review on a white paper, intended to
provide an example lead guide on how to describe NUMA systems in ACPI 6.3.

https://github.com/hisilicon/acpi-numa-whitepaper
https://github.com/hisilicon/acpi-numa-whitepaper/releases/download/v0.93/NUMA_Description_Under_ACPI_6.3_v0.93.pdf

It was prepared in conjunction with the Heterogeneous Memory Sub Team (HMST) of
the UEFI forum which has a mix of firmware and OS people (Linux and others). 

The original motivation for this was that we were writing some docs for a
more specific project (to appear shortly) and realized that only reason
some sections were necessary was because we couldn't find anything
bridging the gap between the ACPI specification and docs like those in
the kernel tree.  Hence this document targeting that hole which is hopefully
of more general use.

Exactly how this will be officially 'released' is yet to be resolved, but 
however that happens we will be maintaining a public source repository,
hopefully allowing this to be a living document, tracking future specs
and also being updated to account for how OS usage of the provided information
changes.

The document is under Creative Commons Attribution 4.0 International License.
It is a Sphinx document. Only output to pdf has been tested and
the build scripts are a bit of a mess.

Thanks to all those who have already given feedback on earlier drafts!
Additional thanks to the members of HMST for some very interesting discussions,
clarifying both my understanding and highlighting areas to focus on in this
guide.

I'm looking for all types of feedback including suggestions for
missing content (as a patch is ideal of course - I'm more than happy
to have some coauthors on this).

Jonathan

p.s. Please share with anyone you think may be interested!



Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7314DB541
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Mar 2022 16:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357369AbiCPPsl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357365AbiCPPsi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 11:48:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53F1D6D39F;
        Wed, 16 Mar 2022 08:47:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C1B71476;
        Wed, 16 Mar 2022 08:47:23 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AECE3F7D7;
        Wed, 16 Mar 2022 08:47:22 -0700 (PDT)
Date:   Wed, 16 Mar 2022 15:47:19 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>, linux-acpi@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mailbox: pcc: Fix spelling mistake "Plaform" ->
 "Platform"
Message-ID: <YjIGh3RUpvBQxWuo@bogus>
References: <20220315202756.2953329-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315202756.2953329-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 15, 2022 at 08:27:56PM +0000, Colin Ian King wrote:
> There is a spelling mistake in a pr_err error message. Fix it.
>

Not sure why you have tagged next, this is in the mainline too.
Anyways,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

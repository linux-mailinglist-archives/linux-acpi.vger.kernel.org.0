Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CAB51D9CB
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441970AbiEFOIp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 10:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiEFOIo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 10:08:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AFA56762;
        Fri,  6 May 2022 07:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D211B835D5;
        Fri,  6 May 2022 14:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699DBC385A9;
        Fri,  6 May 2022 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651845897;
        bh=/HOBhUjG+Mc3GBeGJW8BQ0KRE8eqV2P4POi86WN+/I0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZThZcANqyoaGOsM/UoBGqzFzzd9Ty9Q7im5c343O8MpatQ7Yh3Mz0dOJvdkk75dRA
         wXNtJ+JxaeN86OCjcx/eHR06p5xFSXDYI7vv5SGUzyxVIqOq1BZ5hRiWTsR20m2jPo
         eWjkcyH8W3fiIoTsr+D2NRuAI/mLEYwz62zgciw40yl96Ni6mg1NoiLdsbiaFdsoGz
         001dlzjbqQI3O9LQ9shzfcn9MvyOSP1Oj/X5iVSK5YE5QYbZBUxlbblmLjZ5wSFozK
         LWmOVFdFmYYYeGyp/EhQUW2kcHpWTEw3ojF2r1s2ZVotAnNaWPYP52J1a7xhwyl1z3
         EWcCJ2/bVQ22A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     rjw@rjwysocki.net, alexandre.belloni@bootlin.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: Re: [PATCH 5/7] wil6210: remove debug message for unsupported PM event
References: <20220505015814.3727692-1-rui.zhang@intel.com>
        <20220505015814.3727692-6-rui.zhang@intel.com>
        <875ymkzj9e.fsf@kernel.org>
        <2358992684eb37823378cb48de2775620ee42031.camel@intel.com>
Date:   Fri, 06 May 2022 17:04:50 +0300
In-Reply-To: <2358992684eb37823378cb48de2775620ee42031.camel@intel.com> (Zhang
        Rui's message of "Thu, 05 May 2022 13:24:04 +0800")
Message-ID: <87tua292pp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Zhang Rui <rui.zhang@intel.com> writes:

> Hi, Kalle,
>
> thanks for the quick response.
>
> On Thu, 2022-05-05 at 07:38 +0300, Kalle Valo wrote:
>> Zhang Rui <rui.zhang@intel.com> writes:
>> 
>> > Remove the useless debug message for unsupported PM event because
>> > it is
>> > noop in current code, and it gives a warning when a new event is
>> > introduced, which it doesn't care.
>> 
>> It's a debug message, not a warning, and only visible when debug
>> messages are enabled. Why do you want to remove it?
>
> I'm concerning that people will report problems when they see new
> messages which never shows up previously.
>
> Deleting or keeping this message are both okay to me. But patch 6/7
> indeed introduces a change to this piece of code and it's better for
> you to be aware of it before people starts to complain.
>
>> 
>> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> > Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
>> 
>> Is this really tested on a wil6210 device? Not that it matters, just
>> surprised to see a Tested-by for a wil6210 patch. It's not really
>> common
>> hardware.
>
> No, we just tested the whole patch series on a Dell 9360 laptop, and a
> series of internal test machines. I didn't check if any of them has
> this device or not. Maybe I should remove the tested by in this case?

I think it's best to drop this wil6210 patch. The driver is orphaned
anyway and if anyone complains, they will do that to me :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

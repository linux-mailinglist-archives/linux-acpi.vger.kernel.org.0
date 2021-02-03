Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B84F30DD3B
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 15:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhBCOuw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 09:50:52 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.116]:17738 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233050AbhBCOuv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 09:50:51 -0500
Received: from [100.112.4.31] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-c.us-east-1.aws.symcld.net id A3/80-08509-137BA106; Wed, 03 Feb 2021 14:46:09 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRWlGSWpSXmKPExsWS8eIhj67hdqk
  Egx29TBZfv91mt3hzfDqTxfJ9/YwWnzsms1is3vOC2eLM6UusDmwev7atYfGYdzLQ4/2+q2we
  W662s3h83iQXwBrFmpmXlF+RwJrRcm8tU8EJzoqz876yNzD+Yu9i5OIQEvjPKPFy9ikWCOcFo
  8TOcyeYuxg5OIQFEiWOvYzoYuTkEBFQl5ja0cMGUsMssJhRYvKso1Dd7YwSM/9uYgOpYhPQlt
  iy5ReYzStgK7Hp6UlmEJtFQEXi9JVFYLaoQLjE602fGSFqBCVOznzCAmJzCthJfJjQywKymFl
  AU2L9Ln2QMLOAuMStJ/OZIGx5ie1v54CNkRBQlOj4cYUVwk6Q6Pn3iG0Co+AsJFNnIUyahWTS
  LCSTFjCyrGI0TSrKTM8oyU3MzNE1NDDQNTQ00jXTNTPTS6zSTdYrLdZNTSwu0TXUSywv1iuuz
  E3OSdHLSy3ZxAiMn5QCNqcdjLdff9A7xCjJwaQkytvxSzJBiC8pP6UyI7E4I76oNCe1+BCjDA
  eHkgSvzEqpBCHBotT01Iq0zBxgLMOkJTh4lER427YApXmLCxJzizPTIVKnGHU5Ll+ft4hZiCU
  vPy9VSpw3ZytQkQBIUUZpHtwIWFq5xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYNwxkCk9m
  XgncpldARzABHZG8GuyIkkSElFQDk8Ou27/EZXdfFr7ovV/s2AbBa0s2pXzfV9t1MEVE49zkv
  9sPvLqfrdCyK+bzn9+X8/X3Sd9+zKPQP31Z9EzrD066ex8E3mZvPvR9gbHi7UMXRLYIf18wZ5
  XVtSkLH3zJOltnof7i8SQ1Hs/2987hjcZVR7eYJ3LfCjm9wWXqXo7cGdc6Xl/ef/uCR+aJd6v
  VXbdJv7wjOdP8RfkExzsrWk8Z74s1Mvi4fyVbxX3xyPB0btkKXjON9t+NmrfqH21dYzjDuebJ
  25n/t4Zt6O07u9bs3m+++Hfxql6t98QmGCbXPNBR0xR/GfE9JJCxaH/XnOAmsxuip7j8WxYtq
  +rctztRft3uZBPvgLJ3lwLevnikxFKckWioxVxUnAgAUdbePKYDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-24.tower-416.messagelabs.com!1612363568!2759197!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16509 invoked from network); 3 Feb 2021 14:46:09 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-24.tower-416.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Feb 2021 14:46:09 -0000
Received: from reswpmail01.lenovo.com (unknown [10.62.32.20])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 708FE7D081C8D49A1868;
        Wed,  3 Feb 2021 09:46:08 -0500 (EST)
Received: from localhost.localdomain (10.38.103.179) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 3 Feb 2021
 09:45:44 -0500
Subject: Re: [External] Re: [PATCH v9] platform/x86: thinkpad_acpi: Add
 platform profile support
To:     Hans de Goede <hdegoede@redhat.com>
CC:     <mgross@linux.intel.com>, <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <hadess@hadess.net>,
        <njoshi1@lenovo.com>
References: <markpearson@lenovo.com>
 <20210111162237.3469-1-markpearson@lenovo.com>
 <39c453b5-c6f2-7e45-ee82-64344e800711@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <ab6d9113-2bc6-3c02-bc08-65a0aa217325@lenovo.com>
Date:   Wed, 3 Feb 2021 09:46:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <39c453b5-c6f2-7e45-ee82-64344e800711@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.103.179]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 02/02/2021 09:49, Hans de Goede wrote:
> Hi,
> 
> On 1/11/21 5:22 PM, Mark Pearson wrote:
>> Add support to thinkpad_acpi for Lenovo platforms that have DYTC
>> version 5 support or newer to use the platform profile feature.
>>
>> This will allow users to determine and control the platform modes
>> between low-power, balanced operation and performance modes.
>>
>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> 
> Now that the acpi/platform_profile changes have landed I have
> merged this patch (solving a trivial conflict caused by the
> keyboard_lang changes).
> 
> Thank you for your patch, I've applied this patch to my review-hans 
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
> 
Thanks Hans - sounds great.
Let me know if you find any issues or need any extra tests running.
Happy to do that

Mark

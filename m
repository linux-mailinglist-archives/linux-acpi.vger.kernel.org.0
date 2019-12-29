Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8012C12CB34
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Dec 2019 23:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfL2Wrt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 29 Dec 2019 17:47:49 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54102 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfL2Wrt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Dec 2019 17:47:49 -0500
Received: from 79.184.253.116.ipv4.supernova.orange.pl (79.184.253.116) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id b3a5fd46b8adb14e; Sun, 29 Dec 2019 23:47:47 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH 1/2] cpufreq : cppc: Break out if we match the HiSilicon cppc workaround
Date:   Sun, 29 Dec 2019 23:47:47 +0100
Message-ID: <2965934.S1MOicRWCW@kreacher>
In-Reply-To: <1577152590-25574-1-git-send-email-guohanjun@huawei.com>
References: <1577152590-25574-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, December 24, 2019 2:56:29 AM CET Hanjun Guo wrote:
> Bail out if we match the OEM information, to save some possible
> extra iteration. And update the code to fix minor coding style issue.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 8d8da76..d0ca300 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -39,7 +39,7 @@
>  static struct cppc_cpudata **all_cpu_data;
>  
>  struct cppc_workaround_oem_info {
> -	char oem_id[ACPI_OEM_ID_SIZE +1];
> +	char oem_id[ACPI_OEM_ID_SIZE + 1];
>  	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
>  	u32 oem_revision;
>  };
> @@ -93,8 +93,10 @@ static void cppc_check_hisi_workaround(void)
>  	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
>  		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
>  		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
> -		    wa_info[i].oem_revision == tbl->oem_revision)
> +		    wa_info[i].oem_revision == tbl->oem_revision) {
>  			apply_hisi_workaround = true;
> +			break;
> +		}
>  	}
>  }
>  
> 

Both this and the [2/2] applies as 5.6 material with reworked
subjects and changelog changes.  Thanks!





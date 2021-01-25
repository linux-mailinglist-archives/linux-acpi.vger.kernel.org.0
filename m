Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90837302BEA
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 20:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbhAYToX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 25 Jan 2021 14:44:23 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.115]:23146 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732119AbhAYToO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:44:14 -0500
Received: from [100.112.4.31] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.us-east-1.aws.symcld.net id 80/91-56876-E6E1F006; Mon, 25 Jan 2021 19:39:26 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRWlGSWpSXmKPExsWSLveKTTdPjj/
  BYMkhFouv326zW7w5Pp3JYvm+fkaL1XteMFucOX2J1YHV49e2NSwe7/ddZfPYcrWdxePzJrkA
  lijWzLyk/IoE1oxnx9azF7znq1jw8hpTA+Nlni5GLg4hgf+MEh2bT7NDOC8YJRb8/sgK4exll
  Lj0fxpbFyMnB5uAnsS5s3uZQWwRgSCJp7/fgNnMAhsYJX5/YgWxhQUKJJZMvMYKUVMosfXuGS
  jbSGLlzt3sIDaLgKrExl2/WEBsXgFLidcft4PZQgIpEk1b94HZnAIWEueurAWzGQXEJL6fWsM
  EsUtc4taT+WC2hICAxJI955khbFGJl4//sULY8hK7z/2GqteRWLD7ExuErS2xbOFrZoi9ghIn
  Zz5hmcAoOgvJ2FlIWmYhaZmFpGUBI8sqRtOkosz0jJLcxMwcXUMDA11DQyNdM10zM73EKt1kv
  dJi3dTE4hJdQ73E8mK94src5JwUvbzUkk2MwIhMKWBz2sF4+/UHvUOMkhxMSqK8AY/4EoT4kv
  JTKjMSizPii0pzUosPMcpwcChJ8C6Q4U8QEixKTU+tSMvMASYHmLQEB4+SCK8gSJq3uCAxtzg
  zHSJ1itGYY8LLuYuYOQ4enbeIWYglLz8vVUqcd7IsUKkASGlGaR7cIFjSusQoKyXMy8jAwCDE
  U5BalJtZgir/ilGcg1FJmFcdZApPZl4J3L5XQKcwAZ3y5AwfyCkliQgpqQamCby8p7nKprU5R
  nQyPXdIiiu1Oz3f9fDf4ovGuXfv9NxZ3l/y5L1NgWCl9FGGQO+o6sfRVcoXOgSt3mmcCPxpcd
  XvRf/ZtXubmnu5gu3Yz0Y+tgjfXygYmrTlyNszkRlJk2rKFaY5ubg4T/wU+nWuxLKW2ZvV5q6
  s+7CqdWr5Fp4dzJ05Qr+9cmdmcc4O/Lyp983OnY+1tjpuW+Fw38vseQv3nJ62LR8uaVz3Z3sQ
  dZnpgIr4yuQO+VXS5yTjd1hqCKq7bcqYdr7oYNOfh1yOZ3dGZn7ZytmWv5Eju/TB/HsVU2YrZ
  VcWfvevMX/zQLXP4GtitmJtx32/F74W2+MXMzz4lLTgvcnrnssMSdeVWIozEg21mIuKEwHpa7
  bq1QMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-13.tower-416.messagelabs.com!1611603564!592724!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5506 invoked from network); 25 Jan 2021 19:39:25 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-13.tower-416.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Jan 2021 19:39:25 -0000
Received: from reswpmail03.lenovo.com (unknown [10.62.32.22])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 9042E44D725A5280A362;
        Tue, 26 Jan 2021 03:39:22 +0800 (CST)
Received: from reswpmail02.lenovo.com (10.62.32.21) by reswpmail03.lenovo.com
 (10.62.32.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 25 Jan
 2021 14:39:09 -0500
Received: from reswpmail02.lenovo.com ([fe80::9926:4849:da71:32a2]) by
 reswpmail02.lenovo.com ([fe80::9926:4849:da71:32a2%11]) with mapi id
 15.01.2044.006; Mon, 25 Jan 2021 14:39:20 -0500
From:   Mark RH Pearson <markpearson@lenovo.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Bastien Nocera <hadess@hadess.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [External]  [PATCH 1/1] ACPI: platform-profile: Fix possible
 deadlock in platform_profile_remove()
Thread-Topic: [External]  [PATCH 1/1] ACPI: platform-profile: Fix possible
 deadlock in platform_profile_remove()
Thread-Index: AQHW802a5N+n/u79qUWPR70nMVIfVKo4vGjA
Date:   Mon, 25 Jan 2021 19:39:20 +0000
Message-ID: <71f4b64a29c24f929b578c5127f8a835@lenovo.com>
References: <20210125190909.4384-1-hdegoede@redhat.com>
 <20210125190909.4384-2-hdegoede@redhat.com>
In-Reply-To: <20210125190909.4384-2-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.46.52.30]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Monday, January 25, 2021 2:09 PM
> 
> After a rmmod thinkpad_acpi, lockdep pointed out this possible deadlock:
> 
> Our _show and _store sysfs attr functions get called with the kn->active
> lock held for the sysfs attr and then take the profile_lock.
> sysfs_remove_group() also takes the kn->active lock for the sysfs attr,
> so if we call it with the profile_lock held, then we get an ABBA deadlock.
> 
> platform_profile_remove() must only be called by drivers which have
> first *successfully* called platform_profile_register(). Anything else
> is a driver bug. So the check for cur_profile being set before calling
> sysfs_remove_group() is not necessary and it can be dropped.
> 
> It is safe to call sysfs_remove_group() without holding the profile_lock
> since the attr-group group cannot be re-added until after we clear
> cur_profile.
> 
> Change platform_profile_remove() to only hold the profile_lock while
> clearing the cur_profile, fixing the deadlock.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/platform_profile.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 80e9df427eb8..4a59c5993bde 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -164,13 +164,9 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
> 
>  int platform_profile_remove(void)
>  {
> -	mutex_lock(&profile_lock);
> -	if (!cur_profile) {
> -		mutex_unlock(&profile_lock);
> -		return -ENODEV;
> -	}
> -
>  	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +
> +	mutex_lock(&profile_lock);
>  	cur_profile = NULL;
>  	mutex_unlock(&profile_lock);
>  	return 0;
> --
> 2.29.2
Thanks Hans - good catch! Looks good to me.
Mark

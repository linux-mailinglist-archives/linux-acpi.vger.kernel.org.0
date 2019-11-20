Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A9F1034A3
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2019 07:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfKTGzc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Nov 2019 01:55:32 -0500
Received: from cmta17.telus.net ([209.171.16.90]:44222 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbfKTGzc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Nov 2019 01:55:32 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id XJtfi5luPbg38XJthiUN1z; Tue, 19 Nov 2019 23:55:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1574232930; bh=OV46rrKK3AlKaVTcH03ImQcbVmcPDyo+Zt4TYgMn/W8=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=esd44Qf5mAmFtVDsEiIeMnAN8rNfxHKRHHyO2Re3g61TRbsPGramn9IS7oTiy4rCM
         5fhmeC86ApP5BdP1PuwAuK0M+WU+5GlNMZVYz7VQ8UCVokT0leZCNBf9dJ3VGr9Ru7
         3KhH90yQlwK7Wylr+gl3zF2m7C/Sv8OK3tVlmwTIh4DyjlfHQ9o2M8xD9MMusQnd0M
         TL6Ye0bVELI7ch0LnyxhzIcCYTsKlePpIlzQhAdVe3P0hmq/DvbK4Tvs7ibopxcTJV
         HrNbxvZ4xLrW8EwKvAwra5YH05Da5E78mcHZdwlB91DqxQACoVo+g/vuesZxJPcvdb
         eX+khVzz3z9yA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=O/1HQy1W c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=IxTs3d6C8iS_ZroR3YwA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Linux ACPI'" <linux-acpi@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Sudeep Holla'" <sudeep.holla@arm.com>,
        "'Dmitry Osipenko'" <digetx@gmail.com>
References: <2811202.iOFZ6YHztY@kreacher> <000401d59ee6$959e3da0$c0dab8e0$@net> <CAJZ5v0i1iAjpWju6FiCjP3RvspKDRfSwz4=b_3qgGhhfz8sSrw@mail.gmail.com> <6710300.onecg0m5mP@kreacher>
In-Reply-To: <6710300.onecg0m5mP@kreacher>
Subject: RE: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
Date:   Tue, 19 Nov 2019 22:55:27 -0800
Message-ID: <002a01d59f6f$7f609540$7e21bfc0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdWfJqj8jbmm++hPTPuKf4q4eKkarQAR3rgw
Content-Language: en-ca
X-CMAE-Envelope: MS4wfINi3bG7onvJGbLkiWekPy/0UMVcpoCVXzkkiGC76idCbkDTOHxCBaKa3Ndczy5r2fhPufs4gejwSbFtm6YxzKBp+iQZUVDR5fBAb5zeS2azzvg3uId5
 he0F/REdYKiG5O9BinBjWuvKAZFwfFMrjOKNrRqG/aDd6Z9D1OJ8mFnBLpA1m28mcsmgKFgFh7rkUIoqbzyRtJbyG2VUK3QSZuE1YPFiS7/V1dlwo3eYqeYJ
 kjK3KCniRNet38jKUM4i8KW6TujOrp+Oc1h1jnvcJoqFCnCjJ/kkS68pt0EHfAVX3G05dblzReNuiLYlqwZBHDamNe0gJ7lCm+VsJqGm0q6JFrJoA8GKNlU/
 sDc+jq2TTJDYvn06vbXpc3k9OXDVzJiVSOsXbBlE2+IaBf2k+/k=
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019.11.19 14:14 Rafael J. Wysocki wrote:
> On Tuesday, November 19, 2019 8:17:05 PM CET Rafael J. Wysocki wrote:

...
 
>> However, I now also see that freq_qos_remove_request() doesn't clear
>> the qos field in req which is should do, so freq_qos_add_request()
>> will complain and fail if the object pointed to by req is passed to it
>> again.
>> 
>> I'll send a patch to test for this later today.
>> 
>
> The patch is appended.  Please test it (on top of 5.4-rc8) and report back.
>
> ---
> kernel/power/qos.c |    8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
> Index: linux-pm/kernel/power/qos.c
> ===================================================================
> --- linux-pm.orig/kernel/power/qos.c
> +++ linux-pm/kernel/power/qos.c
> @@ -814,6 +814,8 @@ EXPORT_SYMBOL_GPL(freq_qos_update_reques
>  */
> int freq_qos_remove_request(struct freq_qos_request *req)
> {
> +	int ret;
> +
> 	if (!req)
> 		return -EINVAL;
> 
> @@ -821,7 +823,11 @@ int freq_qos_remove_request(struct freq_
> 		 "%s() called for unknown object\n", __func__))
> 		return -EINVAL;
> 
> -	return freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> +	ret = freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> +	req->qos = NULL;
> +	req->type = 0;
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(freq_qos_remove_request);
 
Yes the patch fixes the problem. Thanks.

I tested several hundred times switching between
passive and active modes with the intel_pstate driver,
including with various CPUs disabled and re-enabled.

... Doug



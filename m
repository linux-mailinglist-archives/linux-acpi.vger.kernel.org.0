Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68E3ABEDC
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 19:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbfIFRjG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 13:39:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44024 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfIFRjF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Sep 2019 13:39:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86HbqCt034052;
        Fri, 6 Sep 2019 17:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=DHtOPf/90YErXldIrRlZjeO6VQjHXm6Nw8CPIho1+Ao=;
 b=TLDSPkvJuX7z7K2HOVV+Gdofu1owV2MioIU2SwZY/k+cj/htAc8X36667CavRbFwTEET
 3QXrbhL9fRj1Uz8qrb5xHgVp9JBxx4OoSV58a8dsrwnxAPYOu8klJC8DH/AOgb9xDFPP
 P+zKqm/xjrXwxvZnAl704Xcow0bWU/dZSK77CUTWXqD3PqzXFzbxqYrvRcnrjBi+TZ5G
 JDC8eogXIaa21PdG3FTwR/fBE1Q70seYZbpMtVqqCLxS7RxOUwvvYjSjPklPMXIne2UC
 xHy+2LkXeunz8WWoCeqruBdIFqte7g+4mmUDVjIYc9yvKjBF5XGgktSCes6Udnn/ofo5 Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uuv16005u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 17:38:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86Hcrpa148893;
        Fri, 6 Sep 2019 17:38:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2uu1b9ye3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 17:38:58 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x86HcugU002308;
        Fri, 6 Sep 2019 17:38:56 GMT
Received: from [10.175.205.101] (/10.175.205.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Sep 2019 10:38:56 -0700
Subject: Re: [pm:bleeding-edge 175/181] drivers/cpuidle/driver.c:270:4: error:
 'cpuidle_prev_governor' undeclared; did you mean 'cpuidle_find_governor'?
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
References: <201909070020.yR8k4sTf%lkp@intel.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <847405da-8a45-653b-d544-25b58ea48db1@oracle.com>
Date:   Fri, 6 Sep 2019 18:38:53 +0100
MIME-Version: 1.0
In-Reply-To: <201909070020.yR8k4sTf%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=773
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909060188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=826 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060187
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/6/19 5:44 PM, kbuild test robot wrote:
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   79f0d67a241f0583b994c73437caa54a4e942737
> commit: 73d2bcced00671c2b724a31c3a4b3401c3e278d0 [175/181] cpuidle: allow governor switch on cpuidle_register_driver()
> config: arm-defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 73d2bcced00671c2b724a31c3a4b3401c3e278d0
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/cpuidle/driver.c: In function 'cpuidle_register_driver':
>>> drivers/cpuidle/driver.c:270:4: error: 'cpuidle_prev_governor' undeclared (first use in this function); did you mean 'cpuidle_find_governor'?
>        cpuidle_prev_governor = cpuidle_curr_governor;
>        ^~~~~~~~~~~~~~~~~~~~~
>        cpuidle_find_governor
>    drivers/cpuidle/driver.c:270:4: note: each undeclared identifier is reported only once for each function it appears in
>    drivers/cpuidle/driver.c: In function 'cpuidle_unregister_driver':
>    drivers/cpuidle/driver.c:301:6: error: 'cpuidle_prev_governor' undeclared (first use in this function); did you mean 'cpuidle_find_governor'?
>      if (cpuidle_prev_governor) {
>          ^~~~~~~~~~~~~~~~~~~~~
>          cpuidle_find_governor
> 
Sorry, didn't build-test with CONFIG_CPU_IDLE_MULTIPLE_DRIVERS=y

Rafael, should I take this message that you queued the series (and thus I submit
a follow up fixing this), or I can just submit a v3 of this particular series?
You didn't answer on the cover letter, so I take it that it's the latter?

	Joao

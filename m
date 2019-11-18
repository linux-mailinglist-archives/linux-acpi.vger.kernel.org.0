Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEC7F10019C
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 10:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfKRJql (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 04:46:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726464AbfKRJqk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Nov 2019 04:46:40 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI9gEJk036479;
        Mon, 18 Nov 2019 04:46:12 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wayf4xpn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 04:46:12 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAI9gKIO037310;
        Mon, 18 Nov 2019 04:46:11 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wayf4xpmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 04:46:11 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAI9jBkx015703;
        Mon, 18 Nov 2019 09:46:10 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 2wa8r65gyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 09:46:10 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAI9k8ld34144528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 09:46:09 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6BC378063;
        Mon, 18 Nov 2019 09:46:08 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41CEC78067;
        Mon, 18 Nov 2019 09:46:04 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.34.246])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 09:46:03 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 16/18] powerpc/papr_scm: Switch to numa_map_to_online_node()
In-Reply-To: <157401276263.43284.12616818803654229788.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com> <157401276263.43284.12616818803654229788.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Mon, 18 Nov 2019 15:16:02 +0530
Message-ID: <87tv71h605.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180087
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> Now that the core exports numa_map_to_online_node() switch to that
> instead of the locally coded duplicate.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c |   21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 33aa59e666e5..ef81515f3b6a 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -284,25 +284,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  	return 0;
>  }
>  
> -static inline int papr_scm_node(int node)
> -{
> -	int min_dist = INT_MAX, dist;
> -	int nid, min_node;
> -
> -	if ((node == NUMA_NO_NODE) || node_online(node))
> -		return node;
> -
> -	min_node = first_online_node;
> -	for_each_online_node(nid) {
> -		dist = node_distance(node, nid);
> -		if (dist < min_dist) {
> -			min_dist = dist;
> -			min_node = nid;
> -		}
> -	}
> -	return min_node;
> -}
> -
>  static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  {
>  	struct device *dev = &p->pdev->dev;
> @@ -347,7 +328,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  
>  	memset(&ndr_desc, 0, sizeof(ndr_desc));
>  	target_nid = dev_to_node(&p->pdev->dev);
> -	online_nid = papr_scm_node(target_nid);
> +	online_nid = numa_map_to_online_node(target_nid);
>  	ndr_desc.numa_node = online_nid;
>  	ndr_desc.target_node = target_nid;
>  	ndr_desc.res = &p->res;
